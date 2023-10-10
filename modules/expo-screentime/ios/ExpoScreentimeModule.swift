import ExpoModulesCore
import FamilyControls

public class ExpoScreentimeModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoScreentime")

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

    AsyncFunction("getApps") { () -> String in
      if #available(iOS 16.0, *) {
        let ac = AuthorizationCenter.shared
        let authTask = Task {
            do {
                try await ac.requestAuthorization(for: .individual)
            }
            catch {
                return "not able to authorize: \(error)"
            }
            return "authorized"
        }
        return await authTask.value
      }
      return "wrong version"
    }

    View(ExpoScreentimeView.self) {
      // Defines a setter for the `name` prop.
      Prop("name") { (view: ExpoScreentimeView, prop: String) in
        print(prop)
      }
    }
  }
}

