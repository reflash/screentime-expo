import FamilyControls

@available(iOS 15, *)
class ScreenTimeSelectAppsModel: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    init() { }
}