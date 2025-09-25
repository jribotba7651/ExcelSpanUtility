using System;

namespace ExcelSpanUtility
{
    public interface IHotkeyService
    {
        bool RegisterHotkey(Action callback);
        void UnregisterHotkey();
        void ChangeHotkey(int modifiers, int virtualKey);
    }
}