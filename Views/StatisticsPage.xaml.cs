using System.Windows.Controls;
using System.Windows;
using System.Collections.ObjectModel;
using DuckSun.Models;
using System.Linq;

namespace DuckSun.Views
{
    public partial class StatisticsPage : ViewBase
    {
        private ObservableCollection<QuestionnaireStatistics> _statistics;

        public StatisticsPage(Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            _statistics = new ObservableCollection<QuestionnaireStatistics>();
            StatisticsGrid.ItemsSource = _statistics;
            LoadStatistics();
        }

        private async void LoadStatistics()
        {
            var questionnaires = await _databaseService.GetQuestionnairesAsync();
            int totalAnswers = 0;
            double totalScore = 0;
            int scoredCount = 0;

            foreach (var questionnaire in questionnaires)
            {
                var answers = await _databaseService.GetFormDataAsync(questionnaire.Id);
                var statistics = new QuestionnaireStatistics
                {
                    Title = questionnaire.Title,
                    AnswerCount = answers.Count,
                    ScoredCount = answers.Count(a => a.IsScored),
                    AverageScore = answers.Any(a => a.IsScored) 
                        ? answers.Where(a => a.IsScored).Average(a => a.TotalScore) 
                        : 0,
                    PassRate = answers.Any(a => a.IsScored)
                        ? (double)answers.Count(a => a.IsScored && a.TotalScore >= 60) / answers.Count(a => a.IsScored)
                        : 0
                };

                _statistics.Add(statistics);
                totalAnswers += statistics.AnswerCount;
                totalScore += answers.Where(a => a.IsScored).Sum(a => a.TotalScore);
                scoredCount += statistics.ScoredCount;
            }

            TotalQuestionnaireBlock.Text = questionnaires.Count.ToString();
            TotalAnswerBlock.Text = totalAnswers.ToString();
            AverageScoreBlock.Text = scoredCount > 0 
                ? (totalScore / scoredCount).ToString("F1") 
                : "0.0";
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            NavigationService?.GoBack();
        }
    }
} 