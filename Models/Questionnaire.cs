using System.Text.RegularExpressions;

namespace DuckSun.Models
{
    public class Questionnaire
    {
        private string _title;
        public long Id { get; set; }
        public string FormKey { get; set; }
        public string Title 
        { 
            get => _title;
            set => _title = StripHtml(value);
        }
        public DateTime CreateTime { get; set; }
        public int Status { get; set; }
        public int SourceType { get; set; }
        public string SourceId { get; set; }
        public long UserId { get; set; }
        public bool IsDeleted { get; set; }
        
        // 统计属性
        public int AnswerCount { get; set; }
        public int ScoredCount { get; set; }
        public double PassRate { get; set; }

        private static string StripHtml(string input)
        {
            if (string.IsNullOrEmpty(input)) return input;
            
            // 移除所有HTML标签
            return Regex.Replace(input, "<.*?>", string.Empty);
        }
    }
} 