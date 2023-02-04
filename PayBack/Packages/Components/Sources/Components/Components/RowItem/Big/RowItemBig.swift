
import UIKit

public class RowItemBig: UIView {
    
    public struct ViewModel {
        let mainTitle: String
        let descriptionTitle: String
        let hasSeparator: Bool
        let isEnabled: Bool
        let amountText: NSAttributedString?
        let amountDescription: String?
        let image: UIImage?
        let delegate: ToggleComponentDelegate?
        
        public init(mainTitle: String,
             descriptionTitle: String,
             hasSeparator: Bool = true,
             isEnabled: Bool = true,
             amountText: NSAttributedString?,
             amountDescription: String?,
             image: UIImage?,
             delegate: ToggleComponentDelegate? = nil) {
            self.mainTitle = mainTitle
            self.descriptionTitle = descriptionTitle
            self.hasSeparator = hasSeparator
            self.isEnabled = isEnabled
            self.amountText = amountText
            self.amountDescription = amountDescription
            self.image = image
            self.delegate = delegate
        }
    }
    
    private typealias Constraints = RowItemBig.Constants.Constraints
    public weak var delegate: ToggleComponentDelegate?
    
    private lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = UIColor.gray
        return img
    }()
    
    private let imgContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.green
        return view
    }()
    
    private let labelsStack: StackedRowLabels = {
        let labels = StackedRowLabels()
        labels.translatesAutoresizingMaskIntoConstraints = false
        return labels
    }()
    
    private lazy var toggle: ToggleComponent = {
        let toggle = ToggleComponent(delegate: self)
        return toggle
    }()
    
    internal lazy var containerStack: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [headerStack, bottomView, separatorView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Spacing.S.floatValue
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.green
        view.roundCorners(by: .Thirty)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.green.cgColor
        return view
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = Brandbook.Font.caption1
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.font = Brandbook.Font.caption1
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.gray
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView.init(arrangedSubviews: [amountLabel, descLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = Spacing.XS3.floatValue
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var headerStack: UIStackView = {
        let wrapper = FlexibleElementWrapper.init(subview: labelsStack)
        let stack = UIStackView.init(arrangedSubviews: [imgContainer, wrapper, toggle])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.spacing = Spacing.S.floatValue
        stack.axis = .horizontal
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
        setUp()
    }
    
    public convenience init(model: RowItemBig.ViewModel) {
        self.init()
        self.configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: RowItemBig.ViewModel) {
        configureSeparator(with: model)
        configureImageView(with: model)
        configureLabelsStack(with: model)
        configureBottomView(with: model)
        configureAmountLabel(with: model)
        configureDescriptionLabel(with: model)
    }
    
    private func configureSeparator(with model: RowItemBig.ViewModel) {
        separatorView.isHidden = !model.hasSeparator
    }
    
    private func configureImageView(with model: RowItemBig.ViewModel) {
        imgView.image = model.image ?? UIImage(systemName: "calendar.circle")
    }
    
    private func configureLabelsStack(with model: RowItemBig.ViewModel) {
        labelsStack.configure(with: .init(type: .twoLineReverse(titleStyle: .predefined(model.descriptionTitle),
                                                                bodyStyle: .predefined(model.mainTitle)),
                                          isEnabled: model.isEnabled))
    }
    
    private func configureBottomView(with model: RowItemBig.ViewModel) {
        bottomView.isHidden = model.amountText == nil && model.amountDescription == nil
    }
    
    private func configureAmountLabel(with model: RowItemBig.ViewModel) {
        amountLabel.isHidden = model.amountText == nil
        amountLabel.attributedText = model.amountText
    }
    
    private func configureDescriptionLabel(with model: RowItemBig.ViewModel) {
        descLabel.isHidden = model.amountDescription == nil
        descLabel.text = model.amountDescription ?? ""
    }
}

// MARK: -SetUp

extension RowItemBig {
    
    func setUp() {
        backgroundColor = .white
        addSubview(containerStack)
        constrainContainerStack()
        constrainSeparatorView()
        constrainImageAndContainer()
        constrainBottomLabelStack()
    }
    
    func constrainContainerStack() {
        containerStack.top(toView: self, constant: Constraints.top)
        containerStack.bottom(toView: self, constant: Constraints.bottom)
        containerStack.left(toView: self, constant: Constraints.left)
        containerStack.right(toView: self, constant: Constraints.right)
    }
    
    func constrainImageAndContainer(){
        imgContainer.addSubview(imgView)
        imgContainer.width(equalTo: Constraints.imgContainerSize)
        imgContainer.height(equalTo: Constraints.imgContainerSize)
        
        imgView.width(equalTo: Constraints.imgSize)
        imgView.height(equalTo: Constraints.imgSize)
        imgView.centerVertically(to: imgContainer)
        imgView.centerHorizontally(to: imgContainer)
    }
    
    func constrainBottomLabelStack() {
        bottomView.addSubview(labelStack)
        labelStack.left(toView: bottomView, constant: Spacing.M.floatValue)
        labelStack.right(toView: bottomView, constant: Spacing.M.floatValue)
        labelStack.top(toView: bottomView, constant: Spacing.XS.floatValue)
        labelStack.bottom(toView: bottomView, constant: Spacing.XS.floatValue)
    }
    
    public override func layoutSubviews() {
        imgContainer.roundCorners(by: .Circle)
    }
    
    func constrainSeparatorView() {
        separatorView.height(equalTo: 1)
    }
}

extension RowItemBig: ToggleComponentDelegate {
    public func didChangeState(to state: ToggleComponent.ToggleState, sender: ToggleComponent) {
        delegate?.didChangeState(to: state, sender: sender)
    }
}

extension RowItemBig {
    public static func getDefaultModel(mainTitle: String,
                                       descriptionTitle: String,
                                       hasSeparator: Bool = true,
                                       isEnabled: Bool = true,
                                       amountText: String?,
                                       amountCcy: CcyAmount?,
                                       amountDescription: String?,
                                       image: UIImage?,
                                       delegate: ToggleComponentDelegate? = nil) -> RowItemBig.ViewModel {
        var amountStr: NSAttributedString? = nil
        if let txt = amountText {
            amountStr = AttributedStringBuilder()
                .text(txt,
                      attributes: [.font(Brandbook.Font.caption1),
                                   .textColor(UIColor.green)])
                .text(amountCcy?.description ?? "",
                      attributes: [.font(Brandbook.Font.body1),
                                   .textColor(UIColor.green)])
                .attributedString
        }
        return RowItemBig.ViewModel.init(mainTitle: mainTitle,
                                         descriptionTitle: descriptionTitle,
                                         hasSeparator: hasSeparator,
                                         isEnabled: isEnabled,
                                         amountText: amountStr,
                                         amountDescription: amountDescription,
                                         image: image,
                                         delegate: delegate)
    }
}
