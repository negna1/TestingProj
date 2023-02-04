
import Foundation

/// Interface of text formatter
public protocol TextFormatter {
    /**
     Formatting text with current textPattern
     
     - Parameters:
     - unformatted: String to convert
     
     - Returns: Formatted text
     */
    func format(_ unformattedText: String?) -> String?
}


public protocol TextRangeFormatter {
    func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue
    func addRange(for text: String?) -> NSRange?
    func deleteRange(for text: String?) -> NSRange?
}

public protocol FormatterSuffix {
    var formatterSuffix: String { get }
}

extension FormatterSuffix {
    
    public var formatterSuffix: String {
        return ""
    }
}
