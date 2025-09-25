using System;
using System.Collections.Generic;

namespace ExcelSpanUtility
{
    public interface IMonitorService
    {
        List<MonitorInfo> GetMonitors();
        MonitorInfo? GetMonitorFromPoint(int x, int y);
        void RefreshMonitors();
        event EventHandler? MonitorsChanged;
    }

    public class MonitorInfo
    {
        public int Index { get; set; }
        public string DeviceName { get; set; } = "";
        public MonitorRect Bounds { get; set; }
        public MonitorRect WorkArea { get; set; }
        public bool IsPrimary { get; set; }
        public int DpiX { get; set; }
        public int DpiY { get; set; }
        public double ScaleFactor => DpiX / 96.0;
        public string DisplayName => $"Monitor {Index + 1} ({Bounds.Width}x{Bounds.Height}) - {(int)(ScaleFactor * 100)}%";
    }

    public struct MonitorRect
    {
        public int X, Y, Width, Height;
    }
}