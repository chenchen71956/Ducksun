using System.Windows.Controls;
using System.Windows;
using System.Collections.ObjectModel;
using DuckSun.Models;
using System.IO;
using System.Text.Json;
using Microsoft.Win32;

namespace DuckSun.Views
{
    public partial class SystemSettingsPage : ViewBase
    {
        private const string SettingsFile = "settings.json";
        private ObservableCollection<QuestionnaireSettingItem> _questionnaireSettings;
        private SystemSettings _settings;

        public SystemSettingsPage(Services.DatabaseService databaseService) : base(databaseService)
        {
            InitializeComponent();
            _questionnaireSettings = new ObservableCollection<QuestionnaireSettingItem>();
            QuestionnaireList.ItemsSource = _questionnaireSettings;
            LoadSettings();
        }

        private async void LoadSettings()
        {
            _settings = LoadSystemSettings();
            
            AutoStartupCheckBox.IsChecked = _settings.AutoStartup;
            EnableAutoScoringCheckBox.IsChecked = _settings.EnableAutoScoring;
            ScoreUnansweredCheckBox.IsChecked = _settings.ScoreUnansweredQuestions;

            var questionnaires = await _databaseService.GetQuestionnairesAsync();
            foreach (var questionnaire in questionnaires)
            {
                var hasRules = (await _databaseService.GetScoreRulesAsync(questionnaire.FormKey)).Any();
                
                var item = new QuestionnaireSettingItem
                {
                    FormKey = questionnaire.FormKey,
                    Title = questionnaire.Title,
                    HasScoreRules = hasRules,
                    IsAutoScoring = _settings.FormAutoScoringSettings.GetValueOrDefault(questionnaire.FormKey, false)
                };
                
                _questionnaireSettings.Add(item);
            }
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

        private void SaveSettings()
        {
            _settings.AutoStartup = AutoStartupCheckBox.IsChecked ?? false;
            _settings.EnableAutoScoring = EnableAutoScoringCheckBox.IsChecked ?? false;
            _settings.ScoreUnansweredQuestions = ScoreUnansweredCheckBox.IsChecked ?? false;
            
            _settings.FormAutoScoringSettings = _questionnaireSettings
                .Where(q => q.HasScoreRules)
                .ToDictionary(q => q.FormKey, q => q.IsAutoScoring);

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

        private void Save_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SaveSettings();
                MessageBox.Show("设置保存成功！", "提示", MessageBoxButton.OK, MessageBoxImage.Information);
                Back();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"保存设置失败：{ex.Message}", "错误", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void Cancel_Click(object sender, RoutedEventArgs e)
        {
            Back();
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            Back();
        }
    }
} 