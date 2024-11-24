using System.Windows.Controls;
using System.Windows;
using System.Collections.ObjectModel;
using DuckSun.Models;
using System.Linq;
using DuckSun.Services;
using System.Threading.Tasks;

namespace DuckSun.Views
{
    public partial class QuestionnaireListPage : ViewBase
    {
        private ObservableCollection<Questionnaire> _questionnaires;
        private bool _isLoading;

        public QuestionnaireListPage(Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            _questionnaires = new ObservableCollection<Questionnaire>();
            QuestionnaireItems.ItemsSource = _questionnaires;
            Loaded += QuestionnaireListPage_Loaded;
        }

        private async void QuestionnaireListPage_Loaded(object sender, RoutedEventArgs e)
        {
            await LoadQuestionnaires();
        }

        private async Task LoadQuestionnaires()
        {
            if (_isLoading) return;
            
            try
            {
                _isLoading = true;
                LoadingIndicator.Visibility = Visibility.Visible;

                var questionnaires = await Task.Run(async () => 
                {
                    var list = await _databaseService.GetQuestionnairesAsync();
                    foreach (var questionnaire in list)
                    {
                        questionnaire.AnswerCount = await _databaseService.GetAnswerCountAsync(questionnaire.Id);
                    }
                    return list;
                });

                _questionnaires.Clear();
                foreach (var questionnaire in questionnaires)
                {
                    _questionnaires.Add(questionnaire);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"加载数据失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            finally
            {
                _isLoading = false;
                LoadingIndicator.Visibility = Visibility.Collapsed;
            }
        }

        private void ViewDetail_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is long questionnaireId)
            {
                NavigationService?.Navigate(new QuestionnaireDetailPage(questionnaireId, _databaseService));
            }
        }

        private void SetAnswer_Click(object sender, RoutedEventArgs e)
        {
            if (sender is Button button && button.Tag is long questionnaireId)
            {
                NavigationService?.Navigate(new ScoringSettingsPage(questionnaireId, _databaseService));
            }
        }

        private void SearchBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (_isLoading) return;

            string searchText = SearchBox.Text?.ToLower() ?? "";
            var filtered = _questionnaires.Where(q => 
                q.Title?.ToLower().Contains(searchText) ?? false).ToList();
            QuestionnaireItems.ItemsSource = filtered;
        }
    }
} 