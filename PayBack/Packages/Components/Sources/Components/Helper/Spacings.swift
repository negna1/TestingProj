

import Foundation
import UIKit
public enum Spacing: Int {
    case XS3 = 2
    case XS2 = 4
    case XS = 8
    case S = 12
    case M = 16
    case L = 20
    case XL = 24
    case XL2 = 28
    case XL3 = 32
    case XL4 = 48
    case XL5 = 64
}

public extension Spacing {
    var floatValue: CGFloat {
        return CGFloat(integerLiteral: self.rawValue)
    }
}
