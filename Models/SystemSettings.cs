namespace DuckSun.Models
{
    public class SystemSettings
    {
        public bool AutoStartup { get; set; } = false;
        public bool EnableAutoScoring { get; set; } = false;
        public bool ScoreUnansweredQuestions { get; set; } = false;
        public Dictionary<string, bool> FormAutoScoringSettings { get; set; } = new Dictionary<string, bool>();
    }
} 