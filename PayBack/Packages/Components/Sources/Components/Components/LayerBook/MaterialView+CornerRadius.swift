

import Foundation
import UIKit

extension UIView {
    // MARK: Rounding corners
    public func roundCorners(by radius: CornerRadius) {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        var value = radius.rawValue
        let height = self.frame.height
        if height > 0 && CGFloat(integerLiteral: radius.rawValue) > height/2 {
            value = Int(height / 2)
        }
        switch radius {
        case .Ten, .Twenty, .Thirty, .Forty, .Fifty:
            self.layer.cornerRadius = CGFloat(value)
        case .Circle:
            self.layer.cornerRadius = frame.height / 2.0
        }

    }
    
    public func roundCorners(by radius: CornerRadius, corners: CACornerMask) {
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        var value = radius.rawValue
        let height = self.frame.height
        if height > 0 && CGFloat(integerLiteral: radius.rawValue) > height/2 {
            value = Int(height / 2)
        }
        self.layer.cornerRadius = CGFloat(value)
        self.layer.maskedCorners = corners
     }
}
