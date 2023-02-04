
import UIKit

public struct ActionsButtonModel {
    
    let icon: UIImage
    let text: String
    let constants: ActionsButtonConstants
    
    public static func card(icon: UIImage, text: String,
                            iconColorStateEnable: UIColor = UIColor.green,
                            iconColorStatePressed: UIColor = .green,
                            iconColorStateDisable: UIColor = .gray,
                            iconContainerStateEnable: UIColor = .gray,
                            iconContainerStatePressed: UIColor = .green,
                            iconContainerStateDisable: UIColor = .green) -> ActionsButtonModel {
        
        let iconColors = [ComplexButton.State.enabled: iconColorStateEnable,
                          ComplexButton.State.pressed: iconColorStatePressed,
                          ComplexButton.State.disable: iconColorStateDisable]
        let iconContainerColors = [ComplexButton.State.enabled: iconContainerStateEnable,
                                   ComplexButton.State.pressed: iconContainerStatePressed,
                                   ComplexButton.State.disable: iconContainerStateDisable]

        let buttonModelType = ActionsButtonConstantsCard(iconColors: iconColors, iconContainerColors: iconContainerColors)
        return ActionsButtonModel( icon: icon,
                                   text: text,
                                   constants: buttonModelType)
    }
    
    public static func transfer(icon: UIImage, text: String,
                                iconColorStateEnable: UIColor = .green,
                                iconColorStatePressed: UIColor = .green,
                                iconColorStateDisable: UIColor = .green,
                                iconContainerStateEnable: UIColor = .green,
                                iconContainerStatePressed: UIColor = .green,
                                iconContainerStateDisable: UIColor = .green) -> ActionsButtonModel {
        
        let iconColors = [ComplexButton.State.enabled: iconColorStateEnable,
                          ComplexButton.State.pressed: iconColorStatePressed,
                          ComplexButton.State.disable: iconColorStateDisable]
        let iconContainerColors = [ComplexButton.State.enabled: iconContainerStateEnable,
                                   ComplexButton.State.pressed: iconContainerStatePressed,
                                   ComplexButton.State.disable: iconContainerStateDisable]
        
        let buttonModelType = ActionsButtonConstantsTransfer(iconColors: iconColors,
                                                             iconContainerColors: iconContainerColors)
        return ActionsButtonModel( icon: icon,
                                   text: text,
                                   constants: buttonModelType)
    }
}
