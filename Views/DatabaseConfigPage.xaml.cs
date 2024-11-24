using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using DuckSun.Models;
using System.IO;
using System.Text.Json;
using System.Collections.ObjectModel;
using Microsoft.Win32;
using System.Linq;

namespace DuckSun.Views
{
    public partial class DatabaseConfigPage : ViewBase
    {
        private const string ConfigFile = "dbconfig.json";
        private const string SettingsFile = "settings.json";
        private SystemSettings _settings;

        public DatabaseConfigPage(Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            LoadConfig();
            LoadSettings();
        }

        private void LoadConfig()
        {
            if (File.Exists(ConfigFile))
            {
                try
                {
                    var json = File.ReadAllText(ConfigFile);
                    var config = JsonSerializer.Deserialize<DatabaseConfig>(json);
                    
                    ServerTextBox.Text = config.Server;
                    PortTextBox.Text = config.Port.ToString();
                    DatabaseTextBox.Text = config.Database;
                    UserIdTextBox.Text = config.UserId;
                    PasswordBox.Password = config.Password;
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"加载配置失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        private void LoadSettings()
        {
            _settings = LoadSystemSettings();
            AutoStartupCheckBox.IsChecked = _settings.AutoStartup;
            EnableAutoScoringCheckBox.IsChecked = _settings.EnableAutoScoring;
            ScoreUnansweredCheckBox.IsChecked = _settings.ScoreUnansweredQuestions;
        }

        private SystemSettings LoadSystemSettings()
        {
            if (File.Exists(SettingsFile))
            {
                try
                {
                    var json = File.ReadAllText(SettingsFile);
                    return JsonSerializer.Deserialize<SystemSettings>(json) ?? new SystemSettings();
                }
                catch
                {
                    return new SystemSettings();
                }
            }
            return new SystemSettings();
        }

        private async void TestConnection_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var config = GetCurrentConfig();
                
                if (string.IsNullOrWhiteSpace(config.Server))
                    throw new Exception("服务器地址不能为空");
                if (string.IsNullOrWhiteSpace(config.Database))
                    throw new Exception("数据库名称不能为空");
                if (string.IsNullOrWhiteSpace(config.UserId))
                    throw new Exception("用户名不能为空");
                if (string.IsNullOrWhiteSpace(config.Password))
                    throw new Exception("密码不能为空");
                if (config.Port <= 0 || config.Port > 65535)
                    throw new Exception("端口号无效");

                var cursor = Mouse.OverrideCursor;
                Mouse.OverrideCursor = Cursors.Wait;
                
                try
                {
                    var service = new Services.DatabaseService(config);
                    await service.TestConnectionAsync();
                    MessageBox.Show("连接成功！", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                finally
                {
                    Mouse.OverrideCursor = cursor;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"连接失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var config = GetCurrentConfig();
                var json = JsonSerializer.Serialize(config, new JsonSerializerOptions { WriteIndented = true });
                File.WriteAllText(ConfigFile, json);

                SaveSettings();

                MessageBox.Show("配置保存成功！", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
                Back();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"保存配置失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void SaveSettings()
        {
            _settings.AutoStartup = AutoStartupCheckBox.IsChecked ?? false;
            _settings.EnableAutoScoring = EnableAutoScoringCheckBox.IsChecked ?? false;
            _settings.ScoreUnansweredQuestions = ScoreUnansweredCheckBox.IsChecked ?? false;

            var json = JsonSerializer.Serialize(_settings, new JsonSerializerOptions { WriteIndented = true });
            File.WriteAllText(SettingsFile, json);

            SetAutoStartup(_settings.AutoStartup);
        }

        private void SetAutoStartup(bool enable)
        {
            try
            {
                using var key = Registry.CurrentUser.OpenSubKey(
                    @"SOFTWARE\Microsoft\Windows\CurrentVersion\Run", true);
                
                if (key != null)
                {
                    if (enable)
                    {
                        var exePath = System.Diagnostics.Process.GetCurrentProcess().MainModule?.FileName;
                        if (!string.IsNullOrEmpty(exePath))
                        {
                            key.SetValue("DuckSun", exePath);
                        }
                    }
                    else
                    {
                        key.DeleteValue("DuckSun", false);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"设置开机自启动失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private DatabaseConfig GetCurrentConfig()
        {
            return new DatabaseConfig
            {
                Server = ServerTextBox.Text,
                Port = int.TryParse(PortTextBox.Text, out int port) ? port : 3306,
                Database = DatabaseTextBox.Text,
                UserId = UserIdTextBox.Text,
                Password = PasswordBox.Password
            };
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            Back();
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            Back();
        }
    }
} 