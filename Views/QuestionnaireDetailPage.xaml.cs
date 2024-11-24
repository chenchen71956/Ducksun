using System.Windows.Controls;
using System.Windows;
using System.Collections.ObjectModel;
using DuckSun.Models;
using DuckSun.Services;
using System.Linq;
using System.Windows.Navigation;
using System.Threading.Tasks;

namespace DuckSun.Views
{
    public partial class QuestionnaireDetailPage : ViewBase
    {
        private readonly long _questionnaireId;
        private ObservableCollection<FormData> _formDataList;

        public QuestionnaireDetailPage(long questionnaireId, Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            _questionnaireId = questionnaireId;
            _formDataList = new ObservableCollection<FormData>();
            AnswerGrid.ItemsSource = _formDataList;
            LoadQuestionnaireData();
        }

        private async Task LoadQuestionnaireData()
        {
            try
            {
                LoadingIndicator.Visibility = Visibility.Visible;

                var data = await Task.Run(async () =>
                {
                    var questionnaires = await _databaseService.GetQuestionnairesAsync();
                    var questionnaire = questionnaires.FirstOrDefault(q => q.Id == _questionnaireId);
                    var answerCount = await _databaseService.GetAnswerCountAsync(_questionnaireId);
                    var formDataList = await _databaseService.GetFormDataAsync(_questionnaireId);
                    
                    return new { questionnaire, answerCount, formDataList };
                });

                if (data.questionnaire != null)
                {
                    TitleBlock.Text = data.questionnaire.Title;
                    CreateTimeBlock.Text = data.questionnaire.CreateTime.ToString("yyyy-MM-dd HH:mm:ss");
                    AnswerCountBlock.Text = data.answerCount.ToString();
                }

                _formDataList.Clear();
                foreach (var formData in data.formDataList)
                {
                    _formDataList.Add(formData);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"加载数据失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                LoadingIndicator.Visibility = Visibility.Collapsed;
            }
        }

        private void ViewAnswerDetail_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is long answerId)
            {
                NavigationService?.Navigate(new AnswerDetailPage(_questionnaireId, answerId, _databaseService));
            }
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }

        private void SetAnswers_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.Navigate(new ScoringSettingsPage(_questionnaireId, _databaseService));
        }
    }
} 