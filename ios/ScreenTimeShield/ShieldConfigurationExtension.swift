import ManagedSettings
import ManagedSettingsUI
import UIKit

let defaultShieldConfiguration = ShieldConfiguration(
  backgroundColor: UIColor.systemBackground,
  icon: UIImage(systemName: "moon.circle.fill",
                variableValue: 1,
                configuration: UIImage.SymbolConfiguration(hierarchicalColor: .systemIndigo)),
  title: ShieldConfiguration.Label(text: "Screentime disabled by the app", color: .label),
  subtitle: ShieldConfiguration.Label(text: "Press unblock in the apps to enable", color: .label)
)

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        return defaultShieldConfiguration
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        return defaultShieldConfiguration
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        return defaultShieldConfiguration
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        return defaultShieldConfiguration
    }
}
