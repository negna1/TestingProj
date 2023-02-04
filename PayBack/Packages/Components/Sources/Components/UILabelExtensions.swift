
import UIKit

public extension UILabel {
    
    func setUp(with type: UILabel.Style) {
        switch type {
        case .predefined(let text):
            self.text = text
        case .custom(let text, let font, let color):
            self.text = text
            self.textColor = color
            self.font = font
        }
    }
}


public extension UILabel {
    
    enum Style {
        case predefined(String)
        case custom(String, UIFont, UIColor)
    }
}
