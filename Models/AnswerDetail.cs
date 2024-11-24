namespace DuckSun.Models
{
    using System;
    using System.ComponentModel;

    public class AnswerDetail : INotifyPropertyChanged
    {
        private double _score;
        
        public QuestionItem Question { get; set; }
        public string Answer { get; set; }
        public bool IsImageAnswer { get; set; }
        
        public double Score
        {
            get => _score;
            set
            {
                if (_score != value)
                {
                    _score = value;
                    OnPropertyChanged(nameof(Score));
                }
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
} 