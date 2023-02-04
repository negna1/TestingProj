

import UIKit

// MARK:- Text Icon Badge Button Component ViewModel
struct TextIconBadgeButtonComponentViewModel {
    private init() {}
}

// MARK:- Layout
extension TextIconBadgeButtonComponentViewModel {
    struct Layout {
        static let height: CGFloat = 32
        static let cornerRadius: CGFloat = height / 2
        
        static let badgeMarginLeading: CGFloat = Spacing.XS.floatValue
        
        static let labelHeight: CGFloat = 14
        static let labelMarginLeading: CGFloat = Spacing.XS.floatValue
        static let labelMarginLeadingNoBadge: CGFloat = Spacing.XS.floatValue
        
        static let iconSize: CGSize = .init(width: 10, height: 10)
        static let iconMarginHor: CGFloat = Spacing.XS.floatValue
        
        private init() {}
    }
}

// MARK:- Color
extension TextIconBadgeButtonComponentViewModel {
    struct Color {
        
        static func foreground(for state: ButtonState) -> UIColor? {
            switch state {
            case .Active: return UIColor.green
            case .Pressed: return UIColor.green
            case .Disabled: return UIColor.green
            }
        }
        
        static func background(state: ButtonState, hasBadge: Bool) -> UIColor? {
            switch (state, hasBadge) {
            case (.Active, false): return UIColor.green
            case (.Pressed, false): return UIColor.green
            case (.Disabled, false): return UIColor.green
            
            case (.Active, true): return UIColor.green
            case (.Pressed, true): return UIColor.green
            case (.Disabled, true): return UIColor.green
            }
        }
        
        private init() {}
    }
}

// MARK:- Font
extension TextIconBadgeButtonComponentViewModel {
    struct Font {
        static let title: UIFont? = Brandbook.Font.button2
        
        private init() {}
    }
}
