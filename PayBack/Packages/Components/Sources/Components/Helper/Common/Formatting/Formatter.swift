
import UIKit


public enum Format {
    case currency(_ ccy: CurrencyLocale)
}

public protocol FormatterConvertible {
    func textRange(for textfield: UITextField, isFocus: Bool)
    func formatted(string: String) -> String
    func editable(string: String) -> String
    func masked(string: String) -> String
}

public enum FormatterFactory {
    static func formatterFor(format: Format) -> FormatterConvertible {
        switch format {
        case .currency(let ccy):
            return CurrencyFormatter(ccy: ccy)
        }
    }
}
