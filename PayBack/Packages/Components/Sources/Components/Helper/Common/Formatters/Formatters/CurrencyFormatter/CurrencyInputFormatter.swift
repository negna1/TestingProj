
import Foundation

open class CurrencyInputFormatter: TextInputFormatter, TextFormatter, TextUnformatter, PrefixableInputFormatter, SuffixableInputFormatter, FormatterSuffix {
    // MARK: - Dependencies
    private let textFormatter: AmountTextFormatter
    private let inputFormatter: AmountTextInputFormatter
    
    // MARK: - Properties
    open var maximumIntegerCharacters: Int {
        set { textFormatter.maximumIntegerCharacters = newValue }
        get { textFormatter.maximumIntegerCharacters }
    }
    open var maximumDecimalCharacters: Int { textFormatter.maximumDecimalCharacters }
    open var prefix: String? { textFormatter.prefix }
    open var suffix: String? { textFormatter.suffix }
    open var groupingSeparator: String { textFormatter.groupingSeparator }
    open var decimalSeparator: String { textFormatter.decimalSeparator }
    open var groupingSize: Int { textFormatter.groupingSize }
    open var numberFormatter: NumberFormatter { textFormatter.numberFormatter }
    open var currency: Currency?
    open var formatterSuffix: String { return " \(currency?.symbol ?? Currency.gel.symbol)"}
    
    // MARK: - Life cycle
    /**
     Initializes formatter with patternString
     */
    public init(currency: Currency? = nil) {
        var textPattern = "#,###.##"
        let patternSymbol: Character = "#"
        if let currency = currency {
            textPattern += " \(currency.symbol)"
        }
        
        textFormatter = AmountTextFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        
        inputFormatter = AmountTextInputFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        
        self.currency = currency
    }
    
    // MARK: - TextFormatter
    open func format(_ unformatted: String?) -> String? {
        guard var unformatted = unformatted,
              unformatted.count != .zero else { return nil }
        
        var digitCountAfterDot = 0
        if unformatted.split(separator: Character(decimalSeparator)).count > 1 {
            digitCountAfterDot = unformatted.split(separator: Character(decimalSeparator)).last?.count ?? .zero
        }
        let digitCountShouldExist = maximumDecimalCharacters
        
        if unformatted.contains(decimalSeparator) == false {
            unformatted += decimalSeparator
        }
        if digitCountAfterDot <= digitCountShouldExist {
            for _ in digitCountAfterDot..<digitCountShouldExist {
                unformatted += "0"
            }
        }
        let formatted = inputFormatter.format(unformatted) ?? ""
        
        return formatted
    }
    
    // MARK: - TextUnformatter
    open func unformat(_ formattedText: String?) -> String? {
        return textFormatter.unformat(formattedText)
    }
}

extension CurrencyInputFormatter: TextRangeFormatter {
    
    // MARK: - TextInputFormatter
    public func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        return inputFormatter.formatInput(
            currentText: currentText,
            range: range,
            replacementString: text
        )
    }
    
    public func addRange(for text: String?) -> NSRange? {
        guard let text = text else {
            return nil
        }
        
        return NSRange.init(location: text.count, length: 0)
    }
    
    public func deleteRange(for text: String?) -> NSRange? {
        guard let text = text, !text.isEmpty,
               text.count != 3 else {
            
            return nil
        }
        
        return NSRange.init(
            location: text.count - 3,
            length: 1)
    }
}
