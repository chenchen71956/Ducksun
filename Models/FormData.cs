namespace DuckSun.Models
{
    public class FormData
    {
        public long Id { get; set; }
        public long FormId { get; set; }
        public string SubmitData { get; set; }
        public DateTime CreateTime { get; set; }
        public int SubmitStatus { get; set; }
        
        // 评分相关属性
        public double TotalScore { get; set; }
        public bool IsScored { get; set; }
    }
} 