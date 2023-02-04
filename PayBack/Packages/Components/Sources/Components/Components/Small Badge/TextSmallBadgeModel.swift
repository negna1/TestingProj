
import Foundation
import UIKit

public extension TextSmallBadge {
    
    struct ViewModel {
        var text: Text
        var badgeColor: UIColor
        
        public init(text: Text, badgeColor: UIColor) {
            self.text = text
            self.badgeColor = badgeColor
        }
    }
    
    struct Text {
        let title: String
        let color: UIColor
        
        public init(title: String, color: UIColor) {
            self.title = title
            self.color = color
        }
    }
}
