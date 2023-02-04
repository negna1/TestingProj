
import Foundation
import UIKit

// FIXME: Enum Cases Better Lower Cased.
public enum ButtonState: Int {
    case Active
    case Pressed
    case Disabled
    
    var isEnabled: Bool {
        switch self {
        case .Active: return true
        case .Pressed: return true
        case .Disabled: return false
        }
    }
}

protocol ButtonComponentViewModelProtocol {
    func backgroundColor(forState state: ButtonState) -> UIColor?
    func titleColor(forState state: ButtonState) -> UIColor?
}

public protocol ButtonProtocol {
    func setContentTitle(title: String)
}
