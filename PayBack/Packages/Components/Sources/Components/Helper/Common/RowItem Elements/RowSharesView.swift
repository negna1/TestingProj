
import UIKit

public class RowSharesView: UIView {

    private let topLabel: LocalLabel = {
        let label = LocalLabel()
        label.font = Brandbook.Font.caption1
        label.textAlignment = .right
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let middleLabel: LocalLabel = {
        let label = LocalLabel()
        label.font = Brandbook.Font.button1
        label.textAlignment = .right
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomLabel: LocalLabel = {
        let label = LocalLabel()
        label.textAlignment = .right
        label.font = Brandbook.Font.caption1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerStack: UIStackView = {
        let stack = UIStackView.init(
            arrangedSubviews: [
                topLabel,
                middleLabel,
                bottomLabel
            ])
        stack.axis = .vertical
        stack.setCustomSpacing(Spacing.XS3.floatValue, after: topLabel)
        stack.setCustomSpacing(Spacing.XS2.floatValue, after: middleLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public init() {
        super.init(frame: .zero)
        setUp()
    }
    
    public convenience init(with model: RowSharesView.ViewModel) {
        self.init()
        configure(with: model)
    }
    
    public convenience init(with model: RowSharesView.OperationViewModel) {
        self.init()
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: RowSharesView.ViewModel) {
        topLabel.isHidden = model.shares == nil
        topLabel.text = model.shares
        middleLabel.text = model.amount.description
        bottomLabel.text = model.percentage.description
        bottomLabel.textColor = model.percentage.textColor
    }
    
    public func configure(with model: RowSharesView.OperationViewModel) {
        topLabel.isHidden = true
        middleLabel.setUp(with: model.title)
        guard let descr = model.`description` else {
            return bottomLabel.isHidden = true
        }
        
        bottomLabel.setUp(with: descr)
    }
    
    private func setUp() {
        addSubview(containerStack)
        containerStack.right(toView: self)
        containerStack.left(toView: self)
        containerStack.centerVertically(to: self)
        containerStack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0).isActive = true
        containerStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0).isActive = true
    }
}

// MARK: ViewModel

public extension RowSharesView {
    
    struct ViewModel {
        var shares: String?
        var amount: CcyAmount
        var percentage: SharesPercent
        
        public init (
            shares: String? = nil,
            amount: CcyAmount,
            percentage: SharesPercent) {
            
            self.shares = shares
            self.amount = amount
            self.percentage = percentage
            
        }
    }
}

public extension RowSharesView {
    
    struct OperationViewModel {
        var title: UILabel.Style
        var `description`: UILabel.Style?
        
        public init(
            title: UILabel.Style,
            description: UILabel.Style? = nil) {
                
                self.title = title
                self.description = description
            }
    }
}
