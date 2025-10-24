//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <hourglass_widget/hourglass_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) hourglass_widget_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "HourglassPlugin");
  hourglass_plugin_register_with_registrar(hourglass_widget_registrar);
}
