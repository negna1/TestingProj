

import UIKit

extension RadioButton {
    
    struct Constants {
        
        struct Colors {
            struct Icon {
                static let enabled = UIColor.clear
                static let selected = UIColor.green
                static let disabled = UIColor.gray
            }
            struct Text {
                static let enabled = UIColor.clear
                static let selected = UIColor.green
                static let disabled = UIColor.gray
            }
        }
        
        struct Fonts {
            static let labelFont = Brandbook.Font.overline1
        }
        
        struct Demensions {
            static let imageViewSize = CGSize(width: Spacing.M.floatValue, height: Spacing.M.floatValue)
            static let stackViewSpacing: CGFloat = 10
        }
        
        struct Images {
            static let iconBlank = UIImage(systemName: "radio")
            static let iconFilled = UIImage(systemName: "radio.fill")
        }
    }
}
