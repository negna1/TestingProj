

import UIKit

public enum CurrencyLocale: String, CaseIterable {
    case gel = "₾"
    case usd = "$"
    case eur = "€"
    case gbp = "£"
    case none = ""
    
    public init(rawValue: String) {
        switch rawValue {
        case "GEL":
            self = .gel
        case "USD":
            self = .usd
        case "EUR":
            self = .eur
        case "GBP":
            self = .gbp
        default:
            self = .none
        }
    }
}

public struct CurrencyFormatter: FormatterConvertible {
    private let ccy: CurrencyLocale
    
    public init(ccy: CurrencyLocale) {
        self.ccy = ccy
    }
    
    private let groupingSeparator = ","
    private let dotSeparator = "."
    private let spaceSeparator = " "
    private let emptyString = ""
    
    public var cursorOffset: Int {
        return -2
    }
    
    private let separatorFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.numberStyle = .decimal
        formatter.roundingMode = .down
        formatter.groupingSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    

    public func masked(string: String) -> String {
        guard string != "" else { return emptyString }
        return string
    }
    
    public func formatted(string: String) -> String {
        guard !string.isEmpty else {
            return emptyString
        }
        
        var formated = string
            .replacingOccurrences(of: groupingSeparator, with: dotSeparator)
            .trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.,").inverted)
        if let idx = formated.range(of: dotSeparator, options: .backwards) {
            formated = formated.replacingOccurrences(
                of: dotSeparator,
                with: emptyString,
                range: formated.startIndex..<idx.lowerBound)
        }
        let number = separatorFormatter.number(from: formated) ?? 0
        formated = separatorFormatter.string(from: number)!
        formated = formated + " \(ccy.rawValue)"
        return formated
    }
    
    public func editable(string: String) -> String {
        var formattedString = string
        if string.isEmpty {
            return " \(ccy.rawValue)"
        }
        formattedString = formattedString.replaceOccurencies(groupingSeparator)
        return formattedString
    }
}

extension CurrencyFormatter {
    
    public func textRange(for textfield: UITextField, isFocus: Bool) {
        
        var selectedRange: UITextRange?
        if let range = textfield.position(from: textfield.endOfDocument, offset: -2) {
            selectedRange = textfield.textRange(from: range, to: range)
        }
        
        if isFocus {
            let deadlineTime = DispatchTime.now() + 0.01
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                textfield.selectedTextRange = selectedRange
            }
        } else {
            textfield.selectedTextRange = selectedRange
        }
    }
}


extension String {
    
    func replaceOccurencies(_ occurrencies: String...) -> String {
        var replacedString = self
        for o in occurrencies {
            replacedString = replacedString.replacingOccurrences(of: o, with: "")
        }
        return replacedString
    }
}
