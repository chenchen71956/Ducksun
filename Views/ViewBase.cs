using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using System.Windows.Navigation;
using System.Windows.Input;
using System.Windows.Data;

namespace DuckSun.Views
{
    public class ViewBase : Page
    {
        protected Services.DatabaseService _databaseService;

        public static readonly DependencyProperty TitleProperty =
            DependencyProperty.Register("Title", typeof(string), typeof(ViewBase), new PropertyMetadata(string.Empty));

        public string Title
        {
            get { return (string)GetValue(TitleProperty); }
            set { SetValue(TitleProperty, value); }
        }

        public ViewBase(Services.DatabaseService databaseService = null)
        {
            _databaseService = databaseService;
        }

        protected void MinimizeWindow()
        {
            if (Window.GetWindow(this) is Window window)
            {
                window.WindowState = WindowState.Minimized;
            }
        }

        protected void MaximizeWindow()
        {
            if (Window.GetWindow(this) is Window window)
            {
                window.WindowState = window.WindowState == WindowState.Maximized 
                    ? WindowState.Normal 
                    : WindowState.Maximized;
            }
        }

        protected void CloseWindow()
        {
            if (Window.GetWindow(this) is Window window)
            {
                window.Close();
            }
        }

        protected void Back()
        {
            NavigationService?.GoBack();
        }

        protected void Navigate(object content)
        {
            NavigationService?.Navigate(content);
        }
    }
} 