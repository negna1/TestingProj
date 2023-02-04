
import UIKit

public enum SmallOvalIconState {
    case normal,pressed,disabled,highlighted
    
    var colors: SmallOvalIconStateModel {
        switch self {
        case .normal:
            return .init(iconTintColor: SmallOvalIconConstants.Colors.iconNormalColor, backgroundColor: SmallOvalIconConstants.Colors.backgroundNoramlColor)
        case .pressed:
            return .init(iconTintColor: SmallOvalIconConstants.Colors.iconPressedColor, backgroundColor: SmallOvalIconConstants.Colors.backgroundPressedColor)
        case .disabled:
            return .init(iconTintColor: SmallOvalIconConstants.Colors.iconDisabledColor, backgroundColor: SmallOvalIconConstants.Colors.backgroundDisabledColor)
        case .highlighted:
            return .init(iconTintColor: SmallOvalIconConstants.Colors.iconActiveColor, backgroundColor: SmallOvalIconConstants.Colors.backgroundActiveColor)
        }
    }
    
    var isEnabled: Bool {
        switch self {
        case .normal:
            return true
        case .pressed:
            return true
        case .disabled:
            return false
        case .highlighted:
            return false
        }
    }
}

struct SmallOvalIconStateModel {
    let iconTintColor,backgroundColor: UIColor?
}
