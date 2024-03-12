
#include "pch.h"
#include "framework.h"
#include "PTCUtils.h"
#include "windows.h"

/// https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getsystemmetrics

// obvious
PTCUTILS_API double ptccpp_get_is_slow_machine()
{
    return GetSystemMetrics(SM_SLOWMACHINE);
}

// also obvious
PTCUTILS_API double ptccpp_get_num_of_monitors()
{
    return GetSystemMetrics(SM_CMONITORS);
}

// primary monitors am i right?
PTCUTILS_API double ptccpp_get_primary_screen_width()
{
    return GetSystemMetrics(SM_CXSCREEN);
}
PTCUTILS_API double ptccpp_get_primary_screen_height()
{
    return GetSystemMetrics(SM_CYSCREEN);
}

// this is not of the first monitor, this is of all monitors combined
PTCUTILS_API double ptccpp_get_full_screen_width()
{
    return GetSystemMetrics(SM_CXVIRTUALSCREEN);
}
// this is not of the first monitor, this is of all monitors combined
PTCUTILS_API double ptccpp_get_full_screen_height()
{
    return GetSystemMetrics(SM_CYVIRTUALSCREEN);
}

PTCUTILS_API double ptccpp_get_window_maximized(HWND ptc)
{
    return IsZoomed(ptc);
}

// easy way to make contact with win utils
PTCUTILS_API double ptccpp_get_sys_metrics(double nIndex)
{
    return GetSystemMetrics((int)nIndex);
}