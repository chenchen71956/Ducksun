namespace DuckSun.Models
{
    public class QuestionnaireStatistics
    {
        public string Title { get; set; }
        public int AnswerCount { get; set; }
        public int ScoredCount { get; set; }
        public double AverageScore { get; set; }
        public double PassRate { get; set; }
    }
} 