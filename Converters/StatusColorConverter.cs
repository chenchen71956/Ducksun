using System;
using System.Windows.Data;
using System.Windows.Media;

namespace DuckSun.Converters
{
    public class StatusColorConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            if (value is int status)
            {
                return status switch
                {
                    0 => new SolidColorBrush((Color)ColorConverter.ConvertFromString("#9CA3AF")),
                    1 => new SolidColorBrush((Color)ColorConverter.ConvertFromString("#3B82F6")),
                    2 => new SolidColorBrush((Color)ColorConverter.ConvertFromString("#10B981")),
                    _ => new SolidColorBrush((Color)ColorConverter.ConvertFromString("#9CA3AF"))
                };
            }
            return new SolidColorBrush((Color)ColorConverter.ConvertFromString("#9CA3AF"));
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
} 