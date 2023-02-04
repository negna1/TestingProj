
import Foundation

open class PhoneInputFormatter: TextInputFormatter, TextFormatter, TextUnformatter {
    // MARK: - Dependencies
    private let textFormatter: DefaultTextFormatter
    private let inputFormatter: DefaultTextInputFormatter
    
    // MARK: - Life cycle
    /**
     Initializes formatter with patternString
     */
    public init() {
        let textPattern = "### ##-##-##"
        let patternSymbol: Character = "#"

        self.textFormatter = DefaultTextFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
        self.inputFormatter = DefaultTextInputFormatter(
            textPattern: textPattern,
            patternSymbol: patternSymbol
        )
    }
    
    // MARK: - TextInputFormatter
    open func formatInput(currentText: String, range: NSRange, replacementString text: String) -> FormattedTextValue {
        return inputFormatter.formatInput(
            currentText: currentText,
            range: range,
            replacementString: text
        )
    }
    
    // MARK: - TextFormatter
    open func format(_ unformattedText: String?) -> String? {
        return textFormatter.format(unformattedText)
    }
    
    // MARK: - TextUnformatter
    open func unformat(_ formatted: String?) -> String? {
        return textFormatter.unformat(formatted)
    }
}
