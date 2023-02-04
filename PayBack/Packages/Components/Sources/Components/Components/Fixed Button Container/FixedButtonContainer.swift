
import UIKit

/**
        let model = FBContainerModel.init(
                        buttonTitle: "ღილაკის ტექსტი",
                        topElement: .pageDescription(
                                        .init(
                                            imageContent: nil,
                                            title: "სათაური",
                                            description: "აღწერა"))) {
                    fixedButton in
                         print(fixedButton.tag)
                    }
        let container = FixedButtonContainer.init(model: model)

 */

public class FixedButtonContainer: UIView {

    private var onTap: ((PrimaryButtonComponent) -> ())?
    private typealias Id = FixedButtonConsts.id
    
    private lazy var button: PrimaryButtonComponent = {
        let button = PrimaryButtonComponent.init(title: "", type: .standard)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(didTapButton), for: .touchUpInside)
        button.id = Id.button
        return button
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Spacing.M.floatValue
        stack.addArrangedSubview(horizontalStack)
        return stack
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = Spacing.M.floatValue
        stack.addArrangedSubview(button)
        stack.id = Id.horizontalStack
        return stack
    }()
    
    private lazy var container: UIView = {
       let view = UIView()
        view.id = Id.Element.left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.height(equalTo: 56)
        return view
    }()
    
    private let separator: UIView = {
       let separator = UIView()
        separator.backgroundColor = UIColor.gray
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public convenience init(model: FBContainerModel) {
        self.init()
        commonInit()
        configure(with: model)
    }
    
    private func commonInit() {
        configureSubviews()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -Subviews
extension FixedButtonContainer {
    private func configureSubviews() {
        configureMainStackLayout()
        configureSeparatorLayout()
        
    }
    
    private func configureMainStackLayout() {
        addSubview(verticalStack)
        verticalStack.stretchLayout(with: Spacing.M.floatValue)
    }
    
    private func configureSeparatorLayout() {
        addSubview(separator)
        separator.left(toView: self)
        separator.right(toView: self)
        separator.top(toView: self)
        separator.height(equalTo: 1)
    }
}

// MARK: -Selector
extension FixedButtonContainer {
    
    @objc func didTapButton() {
        onTap?(button)
    }
}

// MARK: -Configure
public extension FixedButtonContainer {
    
    func configure(with model: FBContainerModel) {
        self.button.setTitle(model.buttonTitle, for: .normal)
        self.onTap = model.onTap
        removeExistingElements()
        configureSeparator(appearence: model.hasSeparator)
        configureTop(element: model.topElement)
        configureBottom(element: model.bottomElement)
        configureLeft(element: model.leftElement)
    }
    
    private func configureTop(element: FixedButtonContainer.TopElement?) {
        guard let element = element else {
            return
        }
        
        let view = element.view
        view.id = Id.Element.top
        verticalStack.insertArrangedSubview(view, at: 0)
    }
    
    private func configureBottom(element: FixedButtonContainer.BottomElement?) {
        guard let element = element else {
            return
        }
        
        let view = element.view
        view.id = Id.Element.bottom
        verticalStack.addArrangedSubview(view)
    }
    
    private func configureLeft(element: FixedButtonContainer.LeftElement?) {
        guard let element = element else {
            return
        }
        
        configureLayout(for: element)
        horizontalStack.insertArrangedSubview(container, at: 0)
    }
    
    private func configureSeparator(appearence: Bool) {
        self.separator.isHidden = !appearence
    }
    
    private func removeExistingElements() {
        removeAllExcept(viewWith: Id.horizontalStack, from: verticalStack)
        removeAllExcept(viewWith: Id.button, from: horizontalStack)
    }
    
    private func configureLayout(for element: FixedButtonContainer.LeftElement) {
        let component = element.view
        component.translatesAutoresizingMaskIntoConstraints = false
        
        container.removeAllSubviews()
        container.addSubview(component)
        component.centerVertically(to: container)
        component.centerHorizontally(to: container)
        component.left(toView: container)
        component.right(toView: container)
    }
    
    private func removeAllExcept(viewWith id: String?, from stack: UIStackView) {
        stack.arrangedSubviews.forEach { view in
            if view.id != id {
                view.removeFromSuperview()
            }
        }
    }
    
    private func removeElement(with id: String?, from stack: UIStackView) {
        stack.arrangedSubviews.forEach { view in
            if view.id == id {
                view.removeFromSuperview()
            }
        }
    }
}

// MARK: Button Updates

public extension FixedButtonContainer {
    
    func setButton(title: String) {
        self.button.setTitle(title, for: .normal)
    }
    
    func setButton(enabled: Bool) {
        enabled
            ? self.button.enableInteraction()
            : self.button.disableInteraction()
    }
    
    func setButtonLoader(isLoading: Bool) {
        self.button.isLoading = isLoading
    }
}

// MARK: Element Updates

public extension FixedButtonContainer {
    
    func update(top element: FixedButtonContainer.TopElement) {
        removeElement(with: Id.Element.top, from: verticalStack)
        configureTop(element: element)
    }
    
    func update(bottom element: FixedButtonContainer.BottomElement) {
        removeElement(with: Id.Element.bottom, from: verticalStack)
        configureBottom(element: element)
    }
    
    func update(left element: FixedButtonContainer.LeftElement) {
        removeElement(with: Id.Element.left, from: horizontalStack)
        configureLeft(element: element)
    }
}
