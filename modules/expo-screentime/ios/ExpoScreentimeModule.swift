import ExpoModulesCore
import FamilyControls
import ManagedSettings
import WidgetKit

public class ExpoScreentimeModule: Module {
  private let decoder = JSONDecoder()
  private let encoder = JSONEncoder()

  public func definition() -> ModuleDefinition {
    Name("ExpoScreentime")

    Events("onChangeTheme")
    Events("onChangeBlocked")

    // OnCreate() {() -> Void in
    //     NotificationCenter.default.addObserver(
    //         forName: Notification.Name("WidgetChangeNotification"),
    //         object: nil,
    //         queue: nil) { [weak self] notification in
    //         guard let self = self else { return }
            
    //         let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
    //         let blocked = userDefaults.bool(forKey: "blocked")
    //         sendEvent("onChangeBlocked", [
    //           "isBlocked": blocked
    //         ]);
    //     }
    // }

    Function("setTheme") { (theme: String) -> Void in
      let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
      userDefaults.set(theme, forKey:"theme")
      sendEvent("onChangeTheme", [
        "theme": theme
      ])
    }

    Function("getTheme") { () -> String in
      let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
      return userDefaults.string(forKey: "theme") ?? "system"
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
        let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
        let data = userDefaults.data(forKey: "ScreenTimeSelection")
        if data != nil {
          let decodedData = try? decoder.decode(
              FamilyActivitySelection.self,
              from: data!
          )
            if let unwrapped = decodedData {
                store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(unwrapped.categoryTokens)
                store.shield.applications = unwrapped.applicationTokens
                userDefaults.set(true, forKey:"blocked")
                sendEvent("onChangeBlocked", [
                  "isBlocked": true
                ]);
                if #available(iOS 14.0, *) {
                  WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
      }
    }

    Function("unblockApps") { () -> Void in
      if #available(iOS 16.0, *) {
        let store = ManagedSettingsStore()
        let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
        store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.none
        store.shield.applications = Set()
        userDefaults.set(false, forKey:"blocked")
        sendEvent("onChangeBlocked", [
          "isBlocked": false
        ]);
        if #available(iOS 14.0, *) {
          WidgetCenter.shared.reloadAllTimelines()
        }
      }
    }
      
  Function("isBlocked") { () -> Bool in
    let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
    return userDefaults.bool(forKey: "blocked")
  }

    Function("selectedAppsData") { () -> String in
      if #available(iOS 16.0, *) {
        let userDefaults = UserDefaults.init(suiteName: "group.screentime.expo")!
        let data = userDefaults.data(forKey: "ScreenTimeSelection")
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

