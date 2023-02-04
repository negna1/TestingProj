

import Foundation

public enum FormatterType {
    case `default`(textPattern: String, patternSymbol: Character)
    case amount(textPattern: String, patternSymbol: Character)
    case phoneNumber
    case currency(currency: Currency)
}

public enum FormatFactory {
    public static func formatter(for type: FormatterType) -> TextInputFormatter {
        switch type {
        case let .default(textPattern, patternSymbol):
            return DefaultTextInputFormatter(textPattern: textPattern, patternSymbol: patternSymbol)
        case let .amount(textPattern, patternSymbol):
            return AmountTextInputFormatter(textPattern: textPattern, patternSymbol: patternSymbol)
        case .phoneNumber:
            return PhoneInputFormatter()
        case .currency(let currency):
            return CurrencyInputFormatter(currency: currency)
        }
    }
}
