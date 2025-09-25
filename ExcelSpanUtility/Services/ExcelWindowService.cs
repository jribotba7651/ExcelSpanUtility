using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text;
using System.Windows.Forms;

namespace ExcelSpanUtility.Services
{
    public class ExcelWindowService : IExcelWindowService
    {
        [DllImport("user32.dll")]
        private static extern bool EnumWindows(EnumWindowsProc enumProc, IntPtr lParam);
        [DllImport("user32.dll")]
        private static extern int GetClassName(IntPtr hWnd, StringBuilder lpClassName, int nMaxCount);
        [DllImport("user32.dll")]
        private static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);
        [DllImport("user32.dll")]
        private static extern bool IsWindowVisible(IntPtr hWnd);
        [DllImport("user32.dll")]
        private static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
        [DllImport("user32.dll")]
        private static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        [DllImport("user32.dll")]
        private static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint processId);
        [DllImport("user32.dll")]
        private static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

        private delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);

        private const uint SWP_NOZORDER = 0x0004;
        private const uint SWP_SHOWWINDOW = 0x0040;
        private const int SW_RESTORE = 9;

        [StructLayout(LayoutKind.Sequential)]
        private struct RECT
        {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }

        private IntPtr? _currentExcelWindow;
        private WindowBounds? _originalBounds;

        public List<ExcelInstance> GetExcelInstances()
        {
            var excelInstances = new List<ExcelInstance>();
            EnumWindows((hWnd, lParam) =>
            {
                if (IsExcelWindow(hWnd) && IsWindowVisible(hWnd))
                {
                    uint processId;
                    GetWindowThreadProcessId(hWnd, out processId);
                    StringBuilder windowText = new StringBuilder(256);
                    GetWindowText(hWnd, windowText, windowText.Capacity);
                    excelInstances.Add(new ExcelInstance
                    {
                        Handle = hWnd,
                        Title = windowText.ToString(),
                        ProcessId = processId,
                        IsSpanned = false
                    });
                }
                return true;
            }, IntPtr.Zero);
            return excelInstances;
        }

        public SpanResult ToggleSpanMode()
        {
            try
            {
                var excelWindows = GetExcelInstances();
                if (excelWindows.Count == 0)
                {
                    return new SpanResult { Success = false, Message = "No Excel windows found" };
                }
                var activeWindow = excelWindows[0].Handle;
                if (_currentExcelWindow == activeWindow && _originalBounds.HasValue)
                {
                    return RestoreWindow();
                }
                else
                {
                    var screens = Screen.AllScreens;
                    if (screens.Length < 2)
                    {
                        return new SpanResult { Success = false, Message = "Multiple monitors required" };
                    }
                    return SpanToMonitors(0, 1);
                }
            }
            catch (Exception ex)
            {
                return new SpanResult { Success = false, Message = $"Error: {ex.Message}", Exception = ex };
            }
        }

        public SpanResult SpanToMonitors(int monitor1Index, int monitor2Index)
        {
            try
            {
                var excelWindows = GetExcelInstances();
                if (excelWindows.Count == 0) return new SpanResult { Success = false, Message = "No Excel windows found" };
                var screens = Screen.AllScreens;
                if (monitor1Index < 0 || monitor1Index >= screens.Length || monitor2Index < 0 || monitor2Index >= screens.Length)
                    return new SpanResult { Success = false, Message = "Invalid monitor indices" };
                var windowHandle = excelWindows[0].Handle;
                GetWindowRect(windowHandle, out RECT currentRect);
                _originalBounds = new WindowBounds { X = currentRect.Left, Y = currentRect.Top, Width = currentRect.Right - currentRect.Left, Height = currentRect.Bottom - currentRect.Top };
                var screen1 = screens[monitor1Index];
                var screen2 = screens[monitor2Index];
                int minX = Math.Min(screen1.WorkingArea.X, screen2.WorkingArea.X);
                int minY = Math.Min(screen1.WorkingArea.Y, screen2.WorkingArea.Y);
                int maxX = Math.Max(screen1.WorkingArea.Right, screen2.WorkingArea.Right);
                int maxY = Math.Max(screen1.WorkingArea.Bottom, screen2.WorkingArea.Bottom);
                int width = maxX - minX;
                int height = maxY - minY;
                ShowWindow(windowHandle, SW_RESTORE);
                SetWindowPos(windowHandle, IntPtr.Zero, minX, minY, width, height, SWP_NOZORDER | SWP_SHOWWINDOW);
                _currentExcelWindow = windowHandle;
                return new SpanResult { Success = true, Message = $"Window spanned across monitors {monitor1Index + 1} and {monitor2Index + 1}" };
            }
            catch (Exception ex)
            {
                return new SpanResult { Success = false, Message = $"Error: {ex.Message}", Exception = ex };
            }
        }

        public SpanResult RestoreWindow()
        {
            try
            {
                if (!_currentExcelWindow.HasValue || !_originalBounds.HasValue)
                    return new SpanResult { Success = false, Message = "No window to restore" };
                var bounds = _originalBounds.Value;
                ShowWindow(_currentExcelWindow.Value, SW_RESTORE);
                SetWindowPos(_currentExcelWindow.Value, IntPtr.Zero, bounds.X, bounds.Y, bounds.Width, bounds.Height, SWP_NOZORDER | SWP_SHOWWINDOW);
                _currentExcelWindow = null;
                _originalBounds = null;
                return new SpanResult { Success = true, Message = "Window restored" };
            }
            catch (Exception ex)
            {
                return new SpanResult { Success = false, Message = $"Error: {ex.Message}", Exception = ex };
            }
        }

        public SpanResult SpanToMonitors(IntPtr windowHandle, int monitor1Index, int monitor2Index)
        {
            try
            {
                var screens = Screen.AllScreens;
                if (monitor1Index < 0 || monitor1Index >= screens.Length || monitor2Index < 0 || monitor2Index >= screens.Length)
                    return new SpanResult { Success = false, Message = "Invalid monitor indices" };

                GetWindowRect(windowHandle, out RECT currentRect);
                _originalBounds = new WindowBounds { X = currentRect.Left, Y = currentRect.Top, Width = currentRect.Right - currentRect.Left, Height = currentRect.Bottom - currentRect.Top };
                var screen1 = screens[monitor1Index];
                var screen2 = screens[monitor2Index];
                int minX = Math.Min(screen1.WorkingArea.X, screen2.WorkingArea.X);
                int minY = Math.Min(screen1.WorkingArea.Y, screen2.WorkingArea.Y);
                int maxX = Math.Max(screen1.WorkingArea.Right, screen2.WorkingArea.Right);
                int maxY = Math.Max(screen1.WorkingArea.Bottom, screen2.WorkingArea.Bottom);
                int width = maxX - minX;
                int height = maxY - minY;
                ShowWindow(windowHandle, SW_RESTORE);
                SetWindowPos(windowHandle, IntPtr.Zero, minX, minY, width, height, SWP_NOZORDER | SWP_SHOWWINDOW);
                _currentExcelWindow = windowHandle;
                return new SpanResult { Success = true, Message = $"Window spanned across monitors {monitor1Index + 1} and {monitor2Index + 1}" };
            }
            catch (Exception ex)
            {
                return new SpanResult { Success = false, Message = $"Error: {ex.Message}", Exception = ex };
            }
        }

        public SpanResult RestoreWindow(IntPtr windowHandle)
        {
            try
            {
                if (!_originalBounds.HasValue)
                    return new SpanResult { Success = false, Message = "No window to restore" };
                var bounds = _originalBounds.Value;
                ShowWindow(windowHandle, SW_RESTORE);
                SetWindowPos(windowHandle, IntPtr.Zero, bounds.X, bounds.Y, bounds.Width, bounds.Height, SWP_NOZORDER | SWP_SHOWWINDOW);
                _currentExcelWindow = null;
                _originalBounds = null;
                return new SpanResult { Success = true, Message = "Window restored" };
            }
            catch (Exception ex)
            {
                return new SpanResult { Success = false, Message = $"Error: {ex.Message}", Exception = ex };
            }
        }

        public SpanResult CreateDualView()
        {
            return new SpanResult { Success = false, Message = "Dual view not yet implemented" };
        }

        private bool IsExcelWindow(IntPtr windowHandle)
        {
            StringBuilder className = new StringBuilder(256);
            GetClassName(windowHandle, className, className.Capacity);
            string classNameStr = className.ToString();

            if (classNameStr.Contains("XLMAIN") || classNameStr.Contains("EXCEL"))
                return true;

            uint processId;
            GetWindowThreadProcessId(windowHandle, out processId);
            try
            {
                var process = Process.GetProcessById((int)processId);
                string processName = process.ProcessName.ToLower();

                if (!processName.Contains("excel"))
                    return false;

                if (processName.Contains("excelspanutilit"))
                    return false;

                StringBuilder windowText = new StringBuilder(256);
                GetWindowText(windowHandle, windowText, windowText.Capacity);
                string windowTitle = windowText.ToString().ToLower();

                if (windowTitle.Contains("excel multi-monitor utility"))
                    return false;

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
