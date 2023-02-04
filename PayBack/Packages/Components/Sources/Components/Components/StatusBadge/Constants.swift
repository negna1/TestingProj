

import UIKit

struct StatusBadgeConsts {
    
    static let size: CGFloat = 40
    static var backgroundColor: UIColor? { UIColor.gray}
    
    struct Content {
        
        struct Success {
            static let icon = "checkmark.seal"
            static var color = UIColor.green
        }
        
        struct Error {
            static let icon =  "x.circle.fill"
            static var color = UIColor.red
        }
        
        struct Warning {
            static let icon = "exclamationmark.triangle"
            static var color = UIColor.lightGray
        }

    }
    
}
