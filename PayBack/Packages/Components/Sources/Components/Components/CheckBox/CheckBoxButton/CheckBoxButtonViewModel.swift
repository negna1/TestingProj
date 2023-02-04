

import UIKit

// MARK:- Layout
extension CheckBoxButton {
    struct Layout {
        // MARK: Properties
        static let tapAreaSize = CGSize(width: 24, height: 24)
        
        static let checkboxSize = CGSize(width: 16, height: 16)
        static let cornerRadius = CGFloat(Spacing.XS2.floatValue)
        
        static let checkmarkSize = CGSize(width: 10, height: 7)
        
        static let labelHeight = CGFloat(18)
        
        static let externalLinkIconSize = CGSize(width: 12, height: 12)
        
        // MARK: Initializers
        private init() {}
    }
}
