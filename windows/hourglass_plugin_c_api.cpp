#include "include/hourglass/hourglass_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "hourglass_plugin.h"

void HourglassPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  hourglass::HourglassPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
