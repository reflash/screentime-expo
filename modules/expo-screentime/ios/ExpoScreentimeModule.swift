import ExpoModulesCore
import FamilyControls
import ManagedSettings

public class ExpoScreentimeModule: Module {
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()

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

    AsyncFunction("authorize") { () -> Bool in
      if #available(iOS 16.0, *) {
        let ac = AuthorizationCenter.shared
        let authTask = Task {
            do {
                try await ac.requestAuthorization(for: .individual)
                return true
            }
            catch {
                return false
            }
        }
        return await authTask.value
      }
      return false
    }

    Function("blockApps") { () -> Void in
      if #available(iOS 16.0, *) {
        let store = ManagedSettingsStore()
        let data = UserDefaults.standard.data(forKey: "ScreenTimeSelection")
        if data != nil {
          let decodedData = try? decoder.decode(
              FamilyActivitySelection.self,
              from: data!
          )
            if let unwrapped = decodedData {
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(unwrapped.categoryTokens)
                store.shield.applications = unwrapped.applicationTokens
            }
        }
      }
    }

    Function("unblockApps") { () -> Void in
      if #available(iOS 16.0, *) {
        let store = ManagedSettingsStore()
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
        store.shield.applications = Set()
      }
    }

    Function("selectedAppsData") { () -> String in
      if #available(iOS 16.0, *) {
        let data = UserDefaults.standard.data(forKey: "ScreenTimeSelection")
        if data != nil {
          let decodedData = try? decoder.decode(
              FamilyActivitySelection.self,
              from: data!
          )
          let jsonData = try encoder.encode(decodedData!)
          let json = String(data: jsonData, encoding: String.Encoding.utf8)
          return json!
        }   
      }
      return "no apps selected yet"
    }

    View(ExpoScreentimeView.self) {
      Prop("name") { (view: ExpoScreentimeView, text: String) in
        view.screenTimeView.setText(text)
      }
      Events("onSelectEvent")
    }
  }
}

