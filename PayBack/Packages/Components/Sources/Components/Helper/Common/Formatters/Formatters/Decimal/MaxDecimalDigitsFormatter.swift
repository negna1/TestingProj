

import Foundation

public class MaxDecimalDigitsFormatter: TextFormatter, TextUnformatter, FormatterSuffix {
    
    var maximumDecimalCharacters: Int
    
    public init(maximumDecimalCharacters: Int) {
        self.maximumDecimalCharacters = maximumDecimalCharacters
    }
    
    public func format(_ unformattedText: String?) -> String? {
        guard let text = unformattedText,
              let doubleInput = Double(text),
              let decimalInput = Decimal(string: text) else {
            return unformattedText
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumDecimalCharacters
        numberFormatter.roundingMode = .down
        
        
        let decimalDigits = decimalInput.significantFractionalDecimalDigits
        let formattedString = decimalDigits > maximumDecimalCharacters ? numberFormatter.string(from: NSNumber.init(floatLiteral: doubleInput)) : text
        
        return formattedString
    }
    
    public func unformat(_ formattedText: String?) -> String? {
        return formattedText
    }
}

extension MaxDecimalDigitsFormatter: TextRangeFormatter {
    
    public func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        let updatedText = currentText.replacingCharacters(in: range, with: text)
        guard let formattedText = format(updatedText) else {
            return FormattedTextValue(formattedText: "", caretBeginOffset: 0)
        }
        return FormattedTextValue(formattedText: formattedText, caretBeginOffset: formattedText.count)
    }
    
    public func addRange(for text: String?) -> NSRange? {
        guard let text = text else {
            return nil
        }
    
        return NSRange.init(location: text.count, length: 0)
    }
    
    public func deleteRange(for text: String?) -> NSRange? {
        guard let text = text, !text.isEmpty, text.count != 1 else {
            return nil
        }
        
        return NSRange.init(
            location: text.count - 1,
            length: 1)
    }
}
