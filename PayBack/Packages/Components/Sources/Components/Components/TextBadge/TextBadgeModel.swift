

import UIKit

extension TextBadge {
    typealias Font = TextBadgeConsts.Font
}

extension TextBadge {

    public struct ViewModel {
        let backgroundColor: UIColor
        let type: `Type`
        
        public init(backgroundColor: UIColor,
                    type: `Type`) {
            self.backgroundColor = backgroundColor
            self.type = type
        }
    }
}

extension TextBadge.ViewModel {
    
    public struct Text {
        let title: String
        let color: UIColor
        
        public init(title: String, color: UIColor) {
            self.title = title
            self.color = color
        }
    }
    
    public struct Icon {
        let icon: UIImage
        let tint: UIColor
        
        public init(icon: UIImage, tint: UIColor) {
            self.icon = icon
            self.tint = tint
        }
    }
}

extension TextBadge.ViewModel {
    public enum `Type` {
        case single(text: Text)
        case double(title: Text, description: Text)
        case icon(title: Text, icon: Icon)
        case uppercase(text: Text)
        case doubleWithCaption(caption: Text, title: Text, description: Text)
        case caption(caption: Text, title: Text, alignment: Alignment = .center)
    }
}

extension TextBadge.ViewModel {
    public enum Alignment {
        case left
        case center
    }
}

extension TextBadge.ViewModel.`Type` {
    
    var leadingTrailing: CGFloat {
        switch self {
        case .single, .caption:
            return Spacing.M.floatValue
        case .double, .icon, .doubleWithCaption:
            return Spacing.S.floatValue
        case .uppercase:
            return TextBadgeConsts.Padding.upercaseLeftRight
        }
    }
    
    var topBottom: CGFloat {
        switch self {
        case .single, .double:
            return Spacing.XS.floatValue
        case .icon:
            return Spacing.XS2.floatValue
        case .uppercase:
            return Spacing.XS2.floatValue
        case .doubleWithCaption:
            return Spacing.XS2.floatValue
        case .caption:
            return Spacing.XS2.floatValue
        }
    }
}


