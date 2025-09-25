using System;

namespace ExcelSpanUtility
{
    public class AppSettings
    {
        public int Monitor1Index { get; set; } = 0;
        public int Monitor2Index { get; set; } = 1;
        public bool AutoSpanOnStartup { get; set; } = false;
        public bool MinimizeToTray { get; set; } = true;
        public string HotkeyToggle { get; set; } = "Ctrl+Shift+S";
        public string HotkeyRestore { get; set; } = "Ctrl+Shift+R";
        public bool StartWithWindows { get; set; } = false;
    }
}
