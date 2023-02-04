
import UIKit

/**
     let rowItem = RowItem()
     rowItem.configure(
     with: .init(
         labels: .init(
             type: .threeLine(
                 titleStyle: .custom("სათაური", Brandbook.Font.caption1, .red),
                 bodyStyle: .predefined("საინფორმაციო ტექსტი"),
                 descriptionStyle: .predefined("ქვესათაური"))
         ),
         leftElements: .single(
             .icon(
                 .init(
                     id: nil,
                     onTap: nil,
                     image: testImage)))
     ))

*/

open class RowItem: UIView {
    
    private typealias Constraints = RowItem.Constants.Constraints
    
    private let labelsStack: StackedRowLabels = {
        let labels = StackedRowLabels()
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    public lazy var containerStack: CacheStackView = {
        let wrapper = FlexibleElementWrapper.init(subview: labelsStack)
        let stack = CacheStackView.init(arrangedSubviews: [leftStack, wrapper, rightStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Spacing.S.floatValue
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var leftStack: CacheStackView = {
        let stack = CacheStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var rightStack: CacheStackView = {
        let stack = CacheStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupStyle()
        setUp()
    }
    
    convenience init(model: RowItem.ViewModel) {
        self.init()
        self.configure(with: model)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -SetUp

extension RowItem {
    
    func setupStyle() {
        backgroundColor = .white
    }
    
    func setUp() {
        addSubview(containerStack)
        addSubview(separatorView)
        configureStackConstraints()
        configureSeparatorViewConsraints()
        configureSelfMinHeight()
    }
    
    func configureSelfMinHeight() {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: Constraints.minHeight).isActive = true
    }
    
    func configureStackConstraints() {
        containerStack.topNotSafe(toView: self, constant: Constraints.top)
        containerStack.bottomNotSafe(toView: self, constant: Constraints.bottom)
        containerStack.leftNotSafe(toView: self, constant: Constraints.left)
        containerStack.rightNotSafe(toView: self, constant: Constraints.right)
    }
    
    func configureSeparatorViewConsraints() {
        separatorView.leftNotSafe(toView: self, constant: Constraints.left)
        separatorView.rightNotSafe(toView: self, constant: Constraints.right)
        separatorView.bottomNotSafe(toView: self)
        separatorView.height(equalTo: 1)
    }
}

// MARK: -Configure

public extension RowItem {
    
    func configure(with model: RowItem.ViewModel) {
        separatorView.isHidden = !model.needSeparator
        labelsStack.configure(with: model.labels)
        configure(elements: model.leftElements, for: leftStack)
        configure(elements: model.rightElements, for: rightStack)
    }
    
    private func configure(
        elements: RowItem.Elements?,
        for stack: CacheStackView) {
        
        guard let elements = elements else {
            return stack.isHidden = true
        }
        
        stack.isHidden = false
        switch elements {
        case .single(let element):
            stack.configure(subviews: [element])
        case .double(let f, let s):
            stack.configure(subviews: [f,s])
        }
    }
}
