using System;
using System.Globalization;
using System.Windows.Data;

namespace DuckSun.Converters
{
    public class ImageUrlsConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is string urls)
            {
                return urls.Split('|', StringSplitOptions.RemoveEmptyEntries);
            }
            return null;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
} 