using System.Linq;
using System.Windows;
using ExcelSpanUtility.Services;

namespace ExcelSpanUtility
{
    public partial class MainWindow : Window
    {
        private readonly IExcelWindowService _excelService;
        private readonly IMonitorService _monitorService;

        public MainWindow(IExcelWindowService excelService, IMonitorService monitorService)
        {
            _excelService = excelService;
            _monitorService = monitorService;

            InitializeComponent();
            WindowState = WindowState.Normal;
            ShowInTaskbar = true;

            LoadData();
        }

        private void LoadData()
        {
            RefreshExcelWindows();
            RefreshMonitors();
        }

        private void RefreshExcelWindows()
        {
            var windows = _excelService.GetExcelInstances();
            ExcelWindowsListBox.ItemsSource = windows;
            StatusText.Text = $"Found {windows.Count} Excel window(s)";
        }

        private void RefreshMonitors()
        {
            var monitors = _monitorService.GetMonitors();
            MonitorsListBox.ItemsSource = monitors;
        }

        private void RefreshButton_Click(object sender, RoutedEventArgs e)
        {
            LoadData();
        }

        private void SpanMonitorsButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedExcel = ExcelWindowsListBox.SelectedItem as ExcelInstance;
            if (selectedExcel == null)
            {
                StatusText.Text = "Please select an Excel window";
                return;
            }

            var selectedMonitors = MonitorsListBox.SelectedItems.Cast<MonitorInfo>().ToList();

            if (selectedMonitors.Count < 2)
            {
                StatusText.Text = "Please select at least 2 monitors";
                return;
            }

            var result = _excelService.SpanToMonitors(selectedExcel.Handle, selectedMonitors[0].Index, selectedMonitors[1].Index);
            StatusText.Text = result.Message;
        }

        private void RestoreButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedExcel = ExcelWindowsListBox.SelectedItem as ExcelInstance;
            if (selectedExcel == null)
            {
                StatusText.Text = "Please select an Excel window";
                return;
            }

            var result = _excelService.RestoreWindow(selectedExcel.Handle);
            StatusText.Text = result.Message;
        }

        public void Shutdown()
        {
            Application.Current.Shutdown();
        }
    }
}
