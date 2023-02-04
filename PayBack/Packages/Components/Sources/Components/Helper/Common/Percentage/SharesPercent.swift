
import UIKit

public struct SharesPercent: CustomStringConvertible {
    
    var value: Double
    
    public init(value: Double) {
        self.value = value
    }
    
    public var description: String {
        let sign: String = value < 0 ? "-" : "+"
        return "\(sign) \(String(format: "%.2f", abs(value)))%"
    }
}

extension SharesPercent {
    var textColor: UIColor {
        return value < 0
        ? UIColor.red
        : UIColor.green
    }
}
