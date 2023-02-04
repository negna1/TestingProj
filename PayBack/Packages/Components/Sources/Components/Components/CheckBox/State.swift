
import Foundation

extension CheckBox {
    public enum State {
        case inactive
        case active
        case disabled
        case indeterminate
        case error
        
        mutating func changeState() {
            switch self {
            case .inactive: self = .active
            case .active: self = .inactive
            case .disabled: break
            case .indeterminate: self = .active
            case .error: self = .active
            }
        }
    }
}
