Rem Win 10
wmic path Win32_VideoController get CurrentHorizontalResolution,CurrentVerticalResolution > screen_resolution.txt

Rem Win 7
Rem wmic desktopmonitor get screenheight, screenwidth > screen_resolution.txt