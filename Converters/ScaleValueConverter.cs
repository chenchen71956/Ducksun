using System;
using System.Globalization;
using System.Windows.Data;

namespace DuckSun.Converters
{
    public class ScaleValueConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is double size && parameter is string scaleStr)
            {
                if (double.TryParse(scaleStr, out double scale))
                {
                    return size * scale;
                }
            }
            return value;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
} 