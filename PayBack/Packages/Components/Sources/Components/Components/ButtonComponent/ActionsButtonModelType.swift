

import UIKit

enum ActionsButtonModelType {
    case transfer
    case card
    
    func width() -> CGFloat {
        switch self {
        case .transfer:
            return CGFloat(ButtonConstant.Action.Transfer.width)
        case .card:
            return CGFloat(ButtonConstant.Action.Card.width)
        }
    }
    
    func height() -> CGFloat {
        switch self {
        case .transfer:
            return CGFloat(ButtonConstant.Action.Transfer.height)
        case .card:
            return CGFloat(ButtonConstant.Action.Card.height)
        }
    }
    
    func contentViewModel(icon: UIImage, text: String) -> ActionsButtonContentViewModel {
        switch self {
        case .transfer:
            return ActionsButtonContentViewModel(text: text,
                                                 image: icon,
                                                 iconContainerSize: ButtonConstant.Action.Transfer.iconContainerSize,
                                                 iconContainerCornerRadius: ButtonConstant.Action.Transfer.iconContainerCornerRadius)
        case .card:
            return ActionsButtonContentViewModel(text: text,
                                                 image: icon,
                                                 iconContainerSize: ButtonConstant.Action.Card.iconContainerSize,
                                                 iconContainerCornerRadius: ButtonConstant.Action.Card.iconContainerCornerRadius)
        }
    }
    
    func enabledStateModel() -> ActionsButtonContentViewStateModel {
        switch self {
        case .transfer:
            let iconColor = UIColor.green
            let iconContainerColor = UIColor.green
            let textColor = UIColor.green
            return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                      iconContainerColor: iconContainerColor,
                                                      iconContainerBorderColor: UIColor.clear,
                                                      textColor: textColor)
        case .card:
            let iconColor = UIColor.green
            let iconContainerColor = UIColor.green
            let textColor = UIColor.green
            return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                      iconContainerColor: iconContainerColor,
                                                      iconContainerBorderColor: UIColor.clear,
                                                      textColor: textColor)
        }
    }
    
    func pressedStateModel() -> ActionsButtonContentViewStateModel {
        switch self {
        case .transfer:
            let iconColor = UIColor.green
            let iconContainerColor = UIColor.green
            let textColor = UIColor.green
            return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                      iconContainerColor: iconContainerColor,
                                                      iconContainerBorderColor: .clear,
                                                      textColor: textColor)
        case .card:
            let iconColor = UIColor.green
            let iconContainerColor = UIColor.green
            let textColor = UIColor.green
            return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                      iconContainerColor: iconContainerColor,
                                                      iconContainerBorderColor: .clear,
                                                      textColor: textColor)
        }
    }
    
    func disabledStateModel() -> ActionsButtonContentViewStateModel {
        switch self {
        case .transfer:
            let iconColor = UIColor.green
            let iconContainerColor = UIColor.green
            let textColor = UIColor.green
            return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                      iconContainerColor: iconContainerColor,
                                                      iconContainerBorderColor: .clear,
                                                      textColor: textColor)
        case .card:
            let iconColor = UIColor.green
            let iconContainerColor = UIColor.green
            let textColor = UIColor.green
            return ActionsButtonContentViewStateModel(iconColor: iconColor,
                                                      iconContainerColor: iconContainerColor,
                                                      iconContainerBorderColor: .clear,
                                                      textColor: textColor)
        }
    }
}
