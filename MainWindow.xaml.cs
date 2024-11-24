using System.Windows;
using System.Windows.Controls;
using DuckSun.Views;
using DuckSun.Services;
using DuckSun.Models;
using System.IO;
using System.Text.Json;
using System.Windows.Input;
using System.Windows.Media;

namespace DuckSun
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private DatabaseService _databaseService;
        private const string ConfigFile = "dbconfig.json";

        public MainWindow()
        {
            InitializeComponent();
            LoadDatabaseConfig();
            rbQuestionList.IsChecked = true;
        }

        private void LoadDatabaseConfig()
        {
            try
            {
                if (File.Exists(ConfigFile))
                {
                    var json = File.ReadAllText(ConfigFile);
                    var config = JsonSerializer.Deserialize<DatabaseConfig>(json);
                    if (config != null)
                    {
                        _databaseService = new DatabaseService(config);
                    }
                }
            }
            catch
            {
                ShowDatabaseConfig();
            }
        }

        private void TitleBar_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            if (e.ClickCount == 2)
            {
                MaximizeButton_Click(null, null);
            }
            else
            {
                DragMove();
            }
        }

        private void MinimizeButton_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState.Minimized;
        }

        private void MaximizeButton_Click(object sender, RoutedEventArgs e)
        {
            WindowState = WindowState == WindowState.Maximized ? WindowState.Normal : WindowState.Maximized;
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            Close();
        }

        private void DatabaseConfig_Click(object sender, RoutedEventArgs e)
        {
            ShowDatabaseConfig();
        }

        private void ShowDatabaseConfig()
        {
            MainFrame.Navigate(new DatabaseConfigPage(_databaseService));
        }

        private void RadioButton_Checked(object sender, RoutedEventArgs e)
        {
            if (sender is RadioButton radioButton && MainFrame != null)
            {
                switch (radioButton.Tag?.ToString())
                {
                    case "QuestionnaireListPage":
                        MainFrame.Navigate(new QuestionnaireListPage(_databaseService));
                        break;
                    case "StatisticsPage":
                        MainFrame.Navigate(new StatisticsPage(_databaseService));
                        break;
                }
            }
        }
    }
}