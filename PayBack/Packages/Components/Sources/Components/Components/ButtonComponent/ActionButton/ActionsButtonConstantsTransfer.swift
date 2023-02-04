

import UIKit

struct ActionsButtonConstantsTransfer: ActionsButtonConstants {
 
    var width: CGFloat = CGFloat(ButtonConstant.Action.Transfer.width)
    var height: CGFloat = CGFloat(ButtonConstant.Action.Transfer.height)
    
    var iconColors: [ComplexButton.State: UIColor]
    var iconContainerColors:[ComplexButton.State: UIColor]
    
    
    func contentViewModel(icon: UIImage, text: String) -> ActionsButtonContentViewModel {
        return ActionsButtonContentViewModel(text: text,
                                             image: icon,
                                             iconContainerSize: ButtonConstant.Action.Transfer.iconContainerSize,
                                             iconContainerCornerRadius: ButtonConstant.Action.Transfer.iconContainerCornerRadius)
    }
    
    func stateModel(for state: ComplexButton.State) -> ActionsButtonContentViewStateModel {
        
        let iconColor = iconColors[state]!
        let iconContainerColor = iconContainerColors[state]!
        switch state {
        case .enabled:

                let textColor = UIColor.green
                return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                          iconContainerColor: iconContainerColor,
                                                          iconContainerBorderColor: UIColor.clear,
                                                          textColor: textColor)
            
        case .pressed:
                let textColor = UIColor.green
                return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                          iconContainerColor: iconContainerColor,
                                                          iconContainerBorderColor: .clear,
                                                          textColor: textColor)
            
        case .disable:

                let textColor = UIColor.green
                return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                          iconContainerColor: iconContainerColor,
                                                          iconContainerBorderColor: .clear,
                                                          textColor: textColor)
            
        }
    }
}
