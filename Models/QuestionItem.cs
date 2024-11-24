using System.Text.Json;
using System.Collections.Generic;
using System.ComponentModel;

namespace DuckSun.Models
{
    public class QuestionItem : INotifyPropertyChanged
    {
        public long Id { get; set; }
        public string FormKey { get; set; }
        public string FormItemId { get; set; }
        public string Type { get; set; }
        public string Label { get; set; }
        public bool ShowLabel { get; set; }
        public string DefaultValue { get; set; }
        public bool Required { get; set; }
        public int Sort { get; set; }
        public string Extra { get; set; }
        
        private double _score;
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

        private string _correctAnswer;
        public string CorrectAnswer
        {
            get => _correctAnswer;
            set
            {
                if (_correctAnswer != value)
                {
                    _correctAnswer = value;
                    OnPropertyChanged(nameof(CorrectAnswer));
                }
            }
        }

        private Dictionary<string, string> _optionsMap;
        public Dictionary<string, string> OptionsMap 
        { 
            get 
            {
                if (_optionsMap == null)
                {
                    _optionsMap = new Dictionary<string, string>();
                    try
                    {
                        if (!string.IsNullOrEmpty(Extra))
                        {
                            var scheme = JsonSerializer.Deserialize<JsonElement>(Extra);
                            if (scheme.TryGetProperty("config", out var config) && 
                                config.TryGetProperty("options", out var options))
                            {
                                foreach (var option in options.EnumerateArray())
                                {
                                    if (option.TryGetProperty("value", out var value) && 
                                        option.TryGetProperty("label", out var label))
                                    {
                                        _optionsMap[value.ToString()] = label.ToString();
                                    }
                                }
                            }
                        }
                    }
                    catch { }
                }
                return _optionsMap;
            }
        }

        public string GetOptionLabel(string value)
        {
            return OptionsMap.TryGetValue(value, out string label) ? label : value;
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
} 