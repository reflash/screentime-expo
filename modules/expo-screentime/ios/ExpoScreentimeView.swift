import ExpoModulesCore

class ExpoScreentimeView: ExpoView {
  let onSelectEvent = EventDispatcher()
  let screenTimeView = ScreenTimeView()
  
  required init(appContext: AppContext? = nil) {
      super.init(appContext: appContext)
      clipsToBounds = true
      addSubview(screenTimeView)
      screenTimeView.setEventDispatcher(onSelectEvent)
    }

    override func layoutSubviews() {
      screenTimeView.frame = bounds
    }
}
