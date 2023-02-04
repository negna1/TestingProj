
import UIKit

// MARK:- Small Icon Text Button Component ViewModel
struct SmallIconTextButtonComponentViewModel {
    private init() {}
}

// MARK:- Layout
extension SmallIconTextButtonComponentViewModel {
    struct Layout {
        static let height: CGFloat = 32
        static let cornerRadius: CGFloat = height / 2
        
        static let iconSize: CGSize = .init(width: 16, height: 16)
        static let iconMarginLeading: CGFloat = Spacing.S.floatValue
        
        static let labelHeight: CGFloat = 14
        static let labelMarginLeading: CGFloat = Spacing.XS.floatValue
        static let labelMarginTrailing: CGFloat = -Spacing.S.floatValue
        
        private init() {}
    }
}

// MARK:- Color
extension SmallIconTextButtonComponentViewModel {
    struct Color {
        
        static func foreground(for state: ButtonState) -> UIColor? {
            switch state {
            case .Active: return UIColor.green
            case .Pressed: return UIColor.green
            case .Disabled: return UIColor.green
            }
        }
        
        static func background(for state: ButtonState) -> UIColor? {
            switch state {
            case .Active: return UIColor.green
            case .Pressed: return UIColor.green
            case .Disabled: return UIColor.green
            }
        }
        
        private init() {}
    }
}

// MARK:- Font
extension SmallIconTextButtonComponentViewModel {
    struct Font {
        static let title: UIFont? = Brandbook.Font.button2
        
        private init() {}
    }
}
