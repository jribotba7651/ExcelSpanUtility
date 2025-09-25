// Services/IExcelWindowService.cs
using System;
using System.Collections.Generic;

namespace ExcelSpanUtility
{
    public interface IExcelWindowService
    {
        SpanResult ToggleSpanMode();
        SpanResult SpanToMonitors(int monitor1Index, int monitor2Index);
        SpanResult SpanToMonitors(IntPtr windowHandle, int monitor1Index, int monitor2Index);
        SpanResult RestoreWindow();
        SpanResult RestoreWindow(IntPtr windowHandle);
        List<ExcelInstance> GetExcelInstances();
        SpanResult CreateDualView();
    }

    public class SpanResult
    {
        public bool Success { get; set; }
        public string Message { get; set; } = "";
        public Exception? Exception { get; set; }
    }

    public class ExcelInstance
    {
        public IntPtr Handle { get; set; }
        public string Title { get; set; } = "";
        public uint ProcessId { get; set; }
        public bool IsSpanned { get; set; }
        public WindowBounds? OriginalBounds { get; set; }
    }

    public struct WindowBounds
    {
        public int X, Y, Width, Height;
        public bool IsMaximized;
    }
}