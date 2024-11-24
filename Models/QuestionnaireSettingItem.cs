namespace DuckSun.Models
{
    public class QuestionnaireSettingItem
    {
        public string FormKey { get; set; }
        public string Title { get; set; }
        public bool IsAutoScoring { get; set; }
        public bool HasScoreRules { get; set; }
    }
} 