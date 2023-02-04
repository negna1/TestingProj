
import UIKit


extension RadioButton {
    
    public typealias OnTap = (RadioButton) -> Void
    public enum State {
        
        private typealias Colors = RadioButton.Constants.Colors
        private typealias Images = RadioButton.Constants.Images
        
        case enabled(onTap: OnTap? = nil)
        case selected(onTap: OnTap? = nil)
        case disabled
        
        var iconColor: UIColor? {
            switch self {
            case .enabled:
                return Colors.Icon.enabled
            case .selected:
                return Colors.Icon.selected
            case .disabled:
                return Colors.Icon.disabled
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .enabled:
                return Images.iconBlank
            case .selected:
                return Images.iconFilled
            case .disabled:
                return Images.iconBlank
            }
        }
        
        var textLabelColor: UIColor? {
            switch self {
            case .enabled:
                return Colors.Text.enabled
            case .selected:
                return Colors.Text.selected
            case .disabled:
                return Colors.Text.disabled
            }
        }
    }
}

extension RadioButton {
    
    public var isSelected: Bool {
        switch self.state {
        case .enabled, .disabled:
            return false
        case .selected:
            return true
        }
    }
}

extension RadioButton.State {
    
    var onTap: RadioButton.OnTap? {
        switch self {
        case .enabled(let handler):
            return handler
        case .selected(onTap: let handler):
           return handler
        case .disabled:
            return nil
        }
    }
}
