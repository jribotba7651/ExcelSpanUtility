# Excel Multi-Monitor Window Utility

A Windows application that allows you to span Excel windows across multiple monitors, optimizing your workspace for multi-monitor setups.

## Features

- **Detect Excel Windows**: Automatically finds all running Excel instances
- **Monitor Detection**: Shows all available monitors with their properties
- **Window Spanning**: Span a single Excel window across multiple selected monitors
- **Window Restoration**: Restore Excel windows to default size
- **Real-time Updates**: Refresh button to update the list of Excel windows and monitors

## Prerequisites

- Windows 10 or later
- .NET 8.0 SDK or Runtime
- Microsoft Excel installed
- Multiple monitors connected

## Installation

### Step 1: Install .NET 8.0
Download and install .NET 8.0 SDK from: https://dotnet.microsoft.com/download/dotnet/8.0

### Step 2: Build the Application
1. Open PowerShell as Administrator
2. Navigate to the project directory:
   ```powershell
   cd C:\Users\juanr\ExcelSpanUtility
   ```
3. Run the build script:
   ```powershell
   .\Build.ps1
   ```

## Usage

1. **Start the Application**:
   - Run `ExcelSpanUtility.exe` from `bin\Release\net8.0-windows\`
   - Or use the Build.ps1 script and choose 'y' when prompted to run

2. **Open Excel Windows**:
   - Make sure you have at least one Excel window open

3. **Select an Excel Window**:
   - Click "Refresh" to update the list
   - Select the Excel window you want to span from the top list

4. **Select Monitors**:
   - Select one or more monitors from the bottom list (hold Ctrl for multiple selection)

5. **Span the Window**:
   - Click "Span Selected Monitors" to expand the Excel window across selected monitors

6. **Restore Window**:
   - Select a window and click "Restore Window" to return it to default size

## Project Structure

```
ExcelSpanUtility/
├── Services/
│   ├── IExcelWindowService.cs    # Interface for Excel window operations
│   ├── ExcelWindowService.cs     # Implementation of window management
│   ├── IMonitorService.cs        # Interface for monitor operations
│   └── MonitorService.cs         # Implementation of monitor detection
├── App.xaml                       # Application resources and configuration
├── App.xaml.cs                   # Application startup and DI configuration
├── MainWindow.xaml               # Main UI layout
├── MainWindow.xaml.cs            # Main window logic
├── ExcelSpanUtility.csproj       # Project file
└── Build.ps1                     # Build script

```

## Troubleshooting

### Excel Windows Not Detected
- Ensure Excel is running with at least one workbook open
- Click the "Refresh" button
- Try running the application as Administrator

### Build Errors
- Ensure .NET 8.0 SDK is installed
- Check that all NuGet packages are restored
- Run `dotnet restore` in the project directory

### Window Not Spanning Correctly
- Check that monitors are properly connected and recognized by Windows
- Ensure the Excel window is not maximized before spanning
- Try restoring the window first, then spanning again

## Development

To modify the application:

1. Open the solution in Visual Studio 2022 or later
2. Make your changes
3. Build using Visual Studio or the Build.ps1 script
4. Test with multiple monitors connected

## License

This utility is provided as-is for personal and commercial use.

## Support

For issues or questions, please check the troubleshooting section or create an issue in the project repository.