import ExpoModulesCore

public class ExpoSettingsModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoSettings")

    Function("getTheme") { () -> String in
      "system"
    }
  }
}
