
import Foundation

public struct CcyAmount: CustomStringConvertible {
    
    var amount: Double
    var ccy: Currency
    var hasFormat: Bool
    
    public init(
        amount: Double,
        ccy: Currency,
        hasFormat: Bool = true) {
        
        self.amount = amount
        self.ccy = ccy
        self.hasFormat = hasFormat
    }
}

public enum Currency: String, CaseIterable {
    
    case gel = "GEL"
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case pbp = "PBP"
    
    var symbol: String {
        switch self {
        case .gel:
            return "₾"
        case .usd:
            return "$"
        case .eur:
            return "€"
        case .gbp:
            return "£"
        case .pbp:
            return "£"
        }
    }
}

extension CcyAmount {
    
    public var description: String {
        if hasFormat,
           let formatted = formatter.format(String(format: "%.2f", abs(amount))) {
            return amount < 0 ? "-\(formatted)" : formatted
        }
        
        return "\(amount) \(ccy.symbol)"
    }
    
    private var formatter: CurrencyInputFormatter {
        return CurrencyInputFormatter.init(currency: ccy)
    }
}
