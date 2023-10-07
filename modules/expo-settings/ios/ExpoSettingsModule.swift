import ExpoModulesCore
import FamilyControls

public class ExpoSettingsModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoSettings")

    Events("onChangeTheme")

    Function("setTheme") { (theme: String) -> Void in
      UserDefaults.standard.set(theme, forKey:"theme")
      sendEvent("onChangeTheme", [
        "theme": theme
      ])
    }

    Function("getTheme") { () -> String in
      UserDefaults.standard.string(forKey: "theme") ?? "system"
    }

    Function("getApps") { () -> String in
      if #available(iOS 16.0, *) {
        let ac = AuthorizationCenter.shared
        let _ = Task {
            do {
                try await ac.requestAuthorization(for: .individual)
            }
            catch {
                // Some error occurred
            }
        }
      }
      return "system"
    }
  }
}
