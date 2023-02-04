

//FIXME: UIKit already imports foundation framwork
import Foundation
import UIKit

public enum ElavationLevel {
    case Ten
    case Twenty
    case Thirty
}

public enum CornerRadius: Int {
    case Ten = 4
    case Twenty = 8
    case Thirty = 12
    case Forty = 16
    case Fifty = 24
    case Circle = 32 // should be views.height / 2.0
}

protocol MaterialView {
    func elevate(level: ElavationLevel)
    func roundCorners(by radius: CornerRadius)
}

extension UIView: MaterialView {
    
}
