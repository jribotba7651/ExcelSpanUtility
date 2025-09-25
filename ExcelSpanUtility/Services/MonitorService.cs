using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace ExcelSpanUtility.Services
{
    public class MonitorService : IMonitorService
    {
        public event EventHandler? MonitorsChanged;

        public List<MonitorInfo> GetMonitors()
        {
            var monitors = new List<MonitorInfo>();
            var screens = Screen.AllScreens;

            for (int i = 0; i < screens.Length; i++)
            {
                var screen = screens[i];
                monitors.Add(new MonitorInfo
                {
                    Index = i,
                    DeviceName = screen.DeviceName,
                    Bounds = new MonitorRect
                    {
                        X = screen.Bounds.X,
                        Y = screen.Bounds.Y,
                        Width = screen.Bounds.Width,
                        Height = screen.Bounds.Height
                    },
                    WorkArea = new MonitorRect
                    {
                        X = screen.WorkingArea.X,
                        Y = screen.WorkingArea.Y,
                        Width = screen.WorkingArea.Width,
                        Height = screen.WorkingArea.Height
                    },
                    IsPrimary = screen.Primary,
                    DpiX = 96,
                    DpiY = 96
                });
            }

            return monitors;
        }

        public MonitorInfo? GetMonitorFromPoint(int x, int y)
        {
            var screen = Screen.FromPoint(new System.Drawing.Point(x, y));
            var screens = Screen.AllScreens;

            for (int i = 0; i < screens.Length; i++)
            {
                if (screens[i].DeviceName == screen.DeviceName)
                {
                    return new MonitorInfo
                    {
                        Index = i,
                        DeviceName = screen.DeviceName,
                        Bounds = new MonitorRect
                        {
                            X = screen.Bounds.X,
                            Y = screen.Bounds.Y,
                            Width = screen.Bounds.Width,
                            Height = screen.Bounds.Height
                        },
                        WorkArea = new MonitorRect
                        {
                            X = screen.WorkingArea.X,
                            Y = screen.WorkingArea.Y,
                            Width = screen.WorkingArea.Width,
                            Height = screen.WorkingArea.Height
                        },
                        IsPrimary = screen.Primary,
                        DpiX = 96,
                        DpiY = 96
                    };
                }
            }

            return null;
        }

        public void RefreshMonitors()
        {
            MonitorsChanged?.Invoke(this, EventArgs.Empty);
        }
    }
}
