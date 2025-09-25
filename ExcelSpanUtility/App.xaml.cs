using System.Windows;
using ExcelSpanUtility.Services;

namespace ExcelSpanUtility
{
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            var excelService = new ExcelWindowService();
            var monitorService = new MonitorService();

            var mainWindow = new MainWindow(excelService, monitorService);
            mainWindow.Show();

            base.OnStartup(e);
        }
    }
}