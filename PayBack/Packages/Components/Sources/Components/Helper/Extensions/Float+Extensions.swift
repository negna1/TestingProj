
import UIKit

public extension Float {
    ///Converts `Float` to `CGFloat`
    var asCGFloat: CGFloat { return CGFloat(self) }
}

extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}

public extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
