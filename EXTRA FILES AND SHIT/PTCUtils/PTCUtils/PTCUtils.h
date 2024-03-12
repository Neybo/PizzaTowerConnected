// The following ifdef block is the standard way of creating macros which make exporting
// from a DLL simpler. All files within this DLL are compiled with the PTCUTILS_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see
// PTCUTILS_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef PTCUTILS_EXPORTS
#define PTCUTILS_API extern "C" __declspec(dllexport) 
#else
#define PTCUTILS_API extern "C" __declspec(dllexport) 
#endif

#include "windows.h"

PTCUTILS_API double ptccpp_get_is_slow_machine();

PTCUTILS_API double ptccpp_get_num_of_monitors();

PTCUTILS_API double ptccpp_get_primary_screen_width();
PTCUTILS_API double ptccpp_get_primary_screen_height();

PTCUTILS_API double ptccpp_get_full_screen_width();
PTCUTILS_API double ptccpp_get_full_screen_height();

PTCUTILS_API double ptccpp_get_window_maximized(HWND ptc);

PTCUTILS_API double ptccpp_get_sys_metrics(double nIndex);