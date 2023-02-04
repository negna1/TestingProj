
import UIKit

public extension CheckBox {
    enum ModelType {
        case checkBox(state: CheckBox.State)
        case checkBoxWithTitle(title: String, state: CheckBox.State)
        case checkBoxWithTitleAndTerm(title: String, term: String, state: CheckBox.State)
    }
}

// MARK:- ViewModel
extension CheckBox {
    struct CheckBoxButtonConfigurations {
        // MARK: Properties
        static func fillColor(forState state: CheckBox.State) -> UIColor {
            switch state {
            case .inactive:  return UIColor.green
            case .active: return UIColor.green
            case .disabled: return UIColor.green
            case .indeterminate: return  UIColor.green
            case .error:  return UIColor.green
            }
        }
        
        static func borderColor(forState state: CheckBox.State) -> UIColor {
            switch state {
            case .inactive: return UIColor.green
            case .active: return UIColor.green
            case .disabled: return UIColor.green
            case .indeterminate: return UIColor.green
            case .error: return UIColor.green
            }
        }
        
        static func fillerImage(forState state: CheckBox.State) -> UIImage? {
            switch state {
            case .inactive: return nil
            case .active: return UIImage(systemName: "checkmark.seal")
            case .disabled: return nil
            case .indeterminate: return UIImage(systemName: "terminal")
            case .error: return  nil
            }
        }
        
        static let checkmarkColor = UIColor.white
        
        // MARK: Initializers
        private init() {}
    }
}

