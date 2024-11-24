using System.Windows.Controls;
using System.Windows;
using System.Collections.ObjectModel;
using DuckSun.Models;
using System.Linq;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;
using System.Windows.Input;

namespace DuckSun.Views
{
    public partial class AnswerDetailPage : ViewBase
    {
        private readonly long _questionnaireId;
        private readonly long _answerId;
        private ObservableCollection<AnswerDetail> _answerDetails;
        private ICommand _previewImageCommand;
        public ICommand PreviewImageCommand => _previewImageCommand ??= new RelayCommand<string>(ShowImagePreview);

        private string _formKey;

        public AnswerDetailPage(long questionnaireId, long answerId, Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            DataContext = this;
            _questionnaireId = questionnaireId;
            _answerId = answerId;
            _answerDetails = new ObservableCollection<AnswerDetail>();
            
            _answerDetails.CollectionChanged += (s, e) =>
            {
                if (e.NewItems != null)
                {
                    foreach (AnswerDetail item in e.NewItems)
                    {
                        item.PropertyChanged += AnswerDetail_PropertyChanged;
                    }
                }
                if (e.OldItems != null)
                {
                    foreach (AnswerDetail item in e.OldItems)
                    {
                        item.PropertyChanged -= AnswerDetail_PropertyChanged;
                    }
                }
            };
            
            AnswerList.ItemsSource = _answerDetails;
            LoadAnswerDetails();
        }

        private async void LoadAnswerDetails()
        {
            try
            {
                var questionnaires = await _databaseService.GetQuestionnairesAsync();
                var questionnaire = questionnaires.FirstOrDefault(q => q.Id == _questionnaireId);
                if (questionnaire != null)
                {
                    TitleBlock.Text = questionnaire.Title;
                    _formKey = questionnaire.FormKey;
                }

                var questions = await _databaseService.GetQuestionItemsAsync(_questionnaireId);
                var formDataList = await _databaseService.GetFormDataAsync(_questionnaireId);
                var formData = formDataList.FirstOrDefault(f => f.Id == _answerId);
                
                if (formData != null)
                {
                    SubmitTimeBlock.Text = formData.CreateTime.ToString("yyyy-MM-dd HH:mm:ss");
                    
                    var submitData = JObject.Parse(formData.SubmitData);
                    
                    foreach (var question in questions.Where(q => 
                        q.Type != "IMAGE" &&
                        submitData.ContainsKey(q.FormItemId)))
                    {
                        question.Label = StripHtml(question.Label);
                        
                        var answer = submitData[question.FormItemId]?.ToString();
                        var answerLabel = submitData[$"{question.FormItemId}label"]?.ToString();
                        var isImageUpload = question.Type.ToLower() == "image_upload";

                        var answerDetail = new AnswerDetail
                        {
                            Question = question,
                            Answer = isImageUpload ? ParseImageUrls(answer) : 
                                    !string.IsNullOrEmpty(answerLabel) ? answerLabel : answer ?? "",
                            Score = 0,
                            IsImageAnswer = isImageUpload
                        };
                        
                        if (!isImageUpload || !string.IsNullOrEmpty(answerDetail.Answer))
                        {
                            _answerDetails.Add(answerDetail);
                        }
                    }
                    
                    UpdateTotalScore();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"加载答案详情失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private static string StripHtml(string input)
        {
            if (string.IsNullOrEmpty(input)) return input;
            return Regex.Replace(input, "<.*?>", string.Empty);
        }

        private void UpdateTotalScore()
        {
            var totalScore = _answerDetails.Sum(a => a.Score);
            TotalScoreBlock.Text = totalScore.ToString("F1");
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            Back();
        }

        private async void AutoScore_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var scoreRules = await _databaseService.GetScoreRulesAsync(_formKey);
                var scores = new Dictionary<string, double>();

                foreach (var answerDetail in _answerDetails)
                {
                    if (answerDetail.Question.Type.ToLower() == "image_upload")
                    {
                        continue;
                    }

                    if (scoreRules.TryGetValue(answerDetail.Question.FormItemId, out var rule))
                    {
                        double score = 0;
                        switch (answerDetail.Question.Type.ToLower())
                        {
                            case "radio":
                            case "checkbox":
                                score = answerDetail.Answer == rule.Answer ? rule.Score : 0;
                                break;

                            case "input":
                            case "textarea":
                                var keywords = rule.Answer.Split(',', '，', ' ')
                                    .Select(k => k.Trim())
                                    .Where(k => !string.IsNullOrEmpty(k));
                                score = keywords.Any(k => answerDetail.Answer.Contains(k, StringComparison.OrdinalIgnoreCase))
                                    ? rule.Score : 0;
                                break;
                        }
                        answerDetail.Score = score;
                        scores[answerDetail.Question.FormItemId] = score;
                    }
                }

                await _databaseService.SaveAnswerScoreAsync(_formKey, _answerId, scores);
                
                UpdateTotalScore();
                MessageBox.Show("自动评分完成！\n注意：图片题需要人工评分。", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"自动评分失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private string ParseImageUrls(string jsonUrls)
        {
            try
            {
                if (string.IsNullOrEmpty(jsonUrls)) return "";

                if (jsonUrls.StartsWith("["))
                {
                    var urls = JArray.Parse(jsonUrls);
                    return string.Join("|", urls.Select(u => 
                    {
                        if (u is JObject obj)
                        {
                            return obj["url"]?.ToString() ?? "";
                        }
                        return u.ToString();
                    }).Where(url => !string.IsNullOrEmpty(url)));
                }
                else if (jsonUrls.StartsWith("{"))
                {
                    var obj = JObject.Parse(jsonUrls);
                    return obj["url"]?.ToString() ?? "";
                }
                
                return jsonUrls;
            }
            catch (Exception)
            {
                return "";
            }
        }

        private void ShowImagePreview(string imageUrl)
        {
            try
            {
                if (!string.IsNullOrEmpty(imageUrl))
                {
                    var psi = new System.Diagnostics.ProcessStartInfo
                    {
                        FileName = imageUrl,
                        UseShellExecute = true
                    };
                    System.Diagnostics.Process.Start(psi);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"打开图片失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void ClosePreview_Click(object sender, RoutedEventArgs e)
        {
            ImagePreviewPopup.IsOpen = false;
            PreviewImage.Source = null;
        }

        private async void AnswerDetail_PropertyChanged(object sender, System.ComponentModel.PropertyChangedEventArgs e)
        {
            if (sender is AnswerDetail answerDetail && e.PropertyName == nameof(AnswerDetail.Score))
            {
                try
                {
                    var scores = new Dictionary<string, double>
                    {
                        { answerDetail.Question.FormItemId, answerDetail.Score }
                    };

                    await _databaseService.SaveAnswerScoreAsync(_formKey, _answerId, scores);
                    UpdateTotalScore();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"保存分数失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }
    }

    public class RelayCommand<T> : ICommand
    {
        private readonly Action<T> _execute;
        
        public RelayCommand(Action<T> execute)
        {
            _execute = execute;
        }

        public event EventHandler CanExecuteChanged;

        public bool CanExecute(object parameter) => true;

        public void Execute(object parameter)
        {
            _execute?.Invoke((T)parameter);
        }
    }
} 