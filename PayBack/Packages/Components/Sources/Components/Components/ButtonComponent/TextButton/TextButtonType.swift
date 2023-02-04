

import UIKit

enum TextButtonType {
    case large
    case small
    case smallIconText
    
    func textColor(for state: ComplexButton.State) -> UIColor {
        switch self {
        case .large, .small, .smallIconText:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        }
    }
    
    var textFont: UIFont {
        switch self {
        case .large:
            return Brandbook.Font.button2
        case .small, .smallIconText:
            return Brandbook.Font.smallButton
        }
    }
    
    var leftRightInset: CGFloat {
        switch self {
        case .large, .small, .smallIconText:
            return .zero
        }
    }
    
    var imageOffset: CGFloat {
        switch self {
        case .large, .small:
            return .zero
        case .smallIconText:
            return CGFloat(-ButtonConstant.Text.SmallIconText.iconDistance)
        }
    }
}
