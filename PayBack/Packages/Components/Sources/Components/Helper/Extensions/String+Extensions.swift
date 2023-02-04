
import UIKit

public extension String {
    ///Checks string against regex
    func matches(regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    ///Checks if string can be parsed to number
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    ///
    ///For More Information refer to `LocalLabel`
    var localizedValue: String {
        return Localizer.shared.localizedValue(for: self)
    }
}

public extension String {
    
    var newLinesReplaced: String {
        self.replacingOccurrences(of: "\n", with: "")
    }
}
