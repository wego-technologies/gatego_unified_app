//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <desktop_window/desktop_window_plugin.h>
#include <flutter_libserialport/flutter_libserialport_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  DesktopWindowPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("DesktopWindowPlugin"));
  FlutterLibserialportPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterLibserialportPlugin"));
}
