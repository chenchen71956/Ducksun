using System.Windows.Controls;
using System.Windows;
using System.Collections.ObjectModel;
using DuckSun.Models;
using System.Linq;
using System.Text.RegularExpressions;
using System.ComponentModel;

namespace DuckSun.Views
{
    public partial class ScoringSettingsPage : ViewBase
    {
        private readonly long? _questionnaireId;
        private ObservableCollection<QuestionItem> _questions;
        private string _formKey;

        public ScoringSettingsPage(Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            _questions = new ObservableCollection<QuestionItem>();
            InitializeQuestionList();
            LoadAllQuestionnaires();
        }

        public ScoringSettingsPage(long questionnaireId, Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            _questionnaireId = questionnaireId;
            _questions = new ObservableCollection<QuestionItem>();
            InitializeQuestionList();
            LoadQuestions();
        }

        private void InitializeQuestionList()
        {
            _questions.CollectionChanged += (s, e) =>
            {
                if (e.NewItems != null)
                {
                    foreach (QuestionItem item in e.NewItems)
                    {
                        item.PropertyChanged += QuestionItem_PropertyChanged;
                    }
                }
                if (e.OldItems != null)
                {
                    foreach (QuestionItem item in e.OldItems)
                    {
                        item.PropertyChanged -= QuestionItem_PropertyChanged;
                    }
                }
            };
            
            QuestionList.ItemsSource = _questions;
        }

        private async void LoadAllQuestionnaires()
        {
            try
            {
                var questionnaires = await _databaseService.GetQuestionnairesAsync();
                TitleBlock.Text = "评分规则设置";
            }
            catch (Exception ex)
            {
                MessageBox.Show($"加载问卷列表失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private async void LoadQuestions()
        {
            if (!_questionnaireId.HasValue) return;

            try
            {
                var questionnaires = await _databaseService.GetQuestionnairesAsync();
                var questionnaire = questionnaires.FirstOrDefault(q => q.Id == _questionnaireId.Value);
                if (questionnaire != null)
                {
                    TitleBlock.Text = questionnaire.Title;
                    _formKey = questionnaire.FormKey;
                }

                var questions = await _databaseService.GetQuestionItemsAsync(_questionnaireId.Value);
                var scoreRules = await _databaseService.GetScoreRulesAsync(_formKey);

                foreach (var question in questions.Where(q => q.Type != "IMAGE"))
                {
                    question.Label = StripHtml(question.Label);
                    if (scoreRules.TryGetValue(question.FormItemId, out var rule))
                    {
                        question.Score = rule.Score;
                        question.CorrectAnswer = rule.Answer;
                    }
                    _questions.Add(question);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"加载题目失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private async void QuestionItem_PropertyChanged(object sender, PropertyChangedEventArgs e)
        {
            if (sender is QuestionItem question && 
                (e.PropertyName == nameof(QuestionItem.Score) || 
                 e.PropertyName == nameof(QuestionItem.CorrectAnswer)))
            {
                try
                {
                    await _databaseService.SaveScoreRuleAsync(
                        _formKey,
                        question.FormItemId,
                        question.Score,
                        question.CorrectAnswer
                    );
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"保存评分规则失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private static string StripHtml(string input)
        {
            if (string.IsNullOrEmpty(input)) return input;
            
            return Regex.Replace(input, "<.*?>", string.Empty);
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }
    }
} 