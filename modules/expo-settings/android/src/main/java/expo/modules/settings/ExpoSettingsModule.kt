package expo.modules.settings

import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ExpoSettingsModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoSettings")

    Function("getTheme") {
      return@Function "system"
    }
  }
}
