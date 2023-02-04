

import UIKit

class CommissionLabel: LocalLabel {
    
    private var amount: Double = 0.0
    private var currency: Currency = .gel
    
    convenience init(amount: Double, ccy: Currency) {
        self.init()
        self.amount = amount
        self.currency = ccy
        self.setCommissionText()
    }
    
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.textAlignment = .center
        self.font = Brandbook.Font.body2
        self.textColor = UIColor.purple
    }
    
    override func handleLocalizationChanges() {
        setCommissionText()
    }
}

// MARK: Custom Commission Text

extension CommissionLabel {
    
    private func setCommissionText() {
        let title = Localizer.shared.localizedValue(for: "brandbook_commission_title")
        self.text = "\(title) \(amount.description) \(currency.symbol)"
    }
}
