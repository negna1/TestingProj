
import Foundation

open class AmountTextFormatter: TextFormatter, TextUnformatter {
    // MARK: - Dependencies
    public let numberFormatter: NumberFormatter
    
    // MARK: - Properties
    open var maximumIntegerCharacters: Int = 14 {
        didSet { numberFormatter.maximumIntegerDigits = maximumIntegerCharacters }
    }
    
    open var maximumDecimalCharacters: Int {
        return numberFormatter.maximumFractionDigits
    }
    
    open var prefix: String? {
        guard !numberFormatter.positivePrefix.isEmpty else { return nil }
        return numberFormatter.positivePrefix
    }
    
    open var suffix: String? {
        guard !numberFormatter.positiveSuffix.isEmpty else { return nil }
        return numberFormatter.positiveSuffix
    }
    
    open var groupingSeparator: String {
        return numberFormatter.groupingSeparator
    }
    
    open var decimalSeparator: String {
        return numberFormatter.decimalSeparator
    }
    
    open var groupingSize: Int {
        return numberFormatter.groupingSize
    }
    
    private let unformattedDecimalSeparator = "."
    private let negativePrefix = "-"
    
    // MARK: - Life cycle
    public init(numberFormatter: NumberFormatter) {
        self.numberFormatter = numberFormatter
    }
    
    public convenience init(textPattern: String, patternSymbol: Character = "#") {
        let formatParser = AmountFormatParser()
        let result = formatParser.parse(format: textPattern, patternSymbol: patternSymbol)
        let numberFormatter = NumberFormatter()
        numberFormatter.positivePrefix = result.prefix
        numberFormatter.positiveSuffix = result.suffix
        numberFormatter.groupingSeparator = result.groupingSeparator
        numberFormatter.decimalSeparator = result.decimalSeparator
        numberFormatter.groupingSize = result.groupingSize
        numberFormatter.maximumFractionDigits = result.maximumFractionDigits
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.allowsFloats = true
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.roundingMode = .down
        numberFormatter.negativePrefix = result.prefix + "-"
        self.init(numberFormatter: numberFormatter)
        numberFormatter.maximumIntegerDigits = maximumIntegerCharacters
    }
    
    // MARK: - TextFormatter
    open func format(_ unformatted: String?) -> String? {
        guard let unformatted = unformatted else { return nil }
        guard !unformatted.isEmpty else { return suffix ?? "" }
        guard unformatted != negativePrefix else { return negativePrefix }
        
        let correctedUnformatted = correctUnformatted(unformatted, decimalSeparator: unformattedDecimalSeparator)
        
        let number = NSDecimalNumber(string: correctedUnformatted)
        
        return numberFormatter.string(from: number)
    }
    
    // MARK: - TextUnformatter
    open func unformat(_ formatted: String?) -> String? {
        guard let formattedString = formatted else { return nil }
        let unformattedString = removeAllFormatSymbols(text: formattedString)
        return unformattedString
    }
    
    // MARK: - Correct unformatted
    private func correctUnformatted(_ unformatted: String, decimalSeparator: String) -> String {
        return unformatted.replacingOccurrences(of: ",", with: decimalSeparator)
    }
    
    // MARK: - Remove all format symbols
    func removeAllFormatSymbols(text: String) -> String {
        var resultText = text
        if let prefix = prefix, !prefix.isEmpty {
            for prefixSymbol in prefix {
                resultText = resultText.removePrefix(String(prefixSymbol))
            }
        }
        if let suffix = suffix, !suffix.isEmpty {
            resultText = resultText.replacingOccurrences(of: suffix, with: "")
        }
        resultText = resultText.replacingOccurrences(of: groupingSeparator, with: "")
        return resultText
    }
}
