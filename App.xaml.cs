using System.Configuration;
using System.Data;
using System.Windows;
using DuckSun.Services;
using DuckSun.Models;

namespace DuckSun
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            // 创建主窗口
            var mainWindow = new MainWindow();
            
            // 设置主窗口并显示
            Current.MainWindow = mainWindow;
            mainWindow.Show();
        }
    }

}
