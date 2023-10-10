package expo.modules.screentime

import android.content.Context
import android.content.SharedPreferences
import androidx.core.os.bundleOf
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition

class ExpoScreentimeModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoScreentime")

    Events("onChangeTheme")

    Function("setTheme") { theme: String ->
      getPreferences().edit().putString("theme", theme).commit()
      this@ExpoSettingsModule.sendEvent("onChangeTheme", bundleOf("theme" to theme))
    }

    Function("getTheme") {
      return@Function getPreferences().getString("theme", "system")
    }

    AsyncFunction("getApps") {
      return "system"
    }

    View(ExpoScreentimeView::class) {
      // Defines a setter for the `name` prop.
      Prop("name") { view: ExpoScreentimeView, prop: String ->
        println(prop)
      }
    }
  }

  private val context
  get() = requireNotNull(appContext.reactContext)

  private fun getPreferences(): SharedPreferences {
    return context.getSharedPreferences(context.packageName + ".settings", Context.MODE_PRIVATE)
  }
}
