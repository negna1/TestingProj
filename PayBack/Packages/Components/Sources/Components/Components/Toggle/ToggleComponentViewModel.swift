
import UIKit

// MARK:- View Model
extension ToggleComponent {
    struct ViewModel {
        // MARK: Properties
        static func backgroundColor(forState state: ToggleComponent.ToggleState) -> UIColor? {
            switch state {
            case .inactive: return UIColor.green
            case .active: return UIColor.green
            }
        }
        
        static let thumbColor: UIColor? = UIColor.green
        
        // MARK: Initializers
        private init() {}
    }
}

// MARK:- Layout
extension ToggleComponent.ViewModel {
    struct Layout {
        // MARK: Properties
        static let size: CGSize = .init(width: 44, height: 24)
        static let cornerRadius: CGFloat = Spacing.XL.floatValue / 2
        
        static let thumbSize: CGSize = .init(width: 16, height: 16)
        static let thumbCornerRadius: CGFloat = thumbSize.height / 2
        static let thumbMarginVertical: CGFloat = Spacing.XS2.floatValue
        static func thumbMarginHorizontal(forState state: ToggleComponent.ToggleState) -> CGFloat {
            switch state {
            case .inactive: return Spacing.XS2.floatValue
            case .active: return size.width - thumbSize.width - Spacing.XS2.floatValue
            }
        }
        
        // MARK: Initializers
        private init() {}
    }
}
