
import UIKit

public class RowPlusAmount: UIView {

    private let labelAmount: RowItem.AmountLabel = {
        let label = RowItem.AmountLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelPoints: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.green
        label.font = Brandbook.Font.caption1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [labelAmount, labelPoints])
        stack.axis = .vertical
        stack.spacing = Spacing.XS2.floatValue
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    convenience init(model: RowPlusAmount.ViewModel) {
        self.init()
        self.configure(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(containerStack)
        containerStack.left(toView: self)
        containerStack.right(toView: self)
        containerStack.centerVertically(to: self)
    }
    
    public func configure(model: RowPlusAmount.ViewModel) {
        labelAmount.text = model.amount.description
        labelPoints.text = "+\(model.plusPoints) Plus ქულა"
    }
}

extension RowPlusAmount {
    
    public struct ViewModel {
        let amount: CcyAmount
        let plusPoints: UInt
        
        public init(
            amount: CcyAmount,
            points: UInt) {
            
            self.amount = amount
            self.plusPoints = points
        }
    }
}
