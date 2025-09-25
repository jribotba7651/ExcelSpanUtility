using System;

namespace ExcelSpanUtility
{
    public interface ISettingsService
    {
        AppSettings GetSettings();
        void SaveSettings(AppSettings settings);
        event EventHandler<AppSettings>? SettingsChanged;
    }
}