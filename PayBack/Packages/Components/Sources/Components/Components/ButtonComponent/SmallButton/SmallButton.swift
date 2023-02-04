

import UIKit


public class SmallButton: UIView, ButtonControl {
    
    // MARK: - Private properties
    private var action: ButtonAction?
    private var widthConstraint: NSLayoutConstraint!
    
    private var contentView = IconBadgeButtonContentView()

    private lazy var internalButton: ComplexButton = {
        let button = ComplexButton(contentView: self.contentView)
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.cornerRadius = CGFloat(ButtonConstant.Small.cornerRadius)
        button.borderWidth = .zero
        button.borderStyle = .solid
        return button
    }()
    
    // MARK: - ButtonControl protocol properties
    public var isEnabled: Bool {
        get { return internalButton.isEnabled }
        set { internalButton.isEnabled = newValue }
    }
    
    // MARK: - Initializers
    public convenience init(model: SmallButtonViewModel, action: ButtonAction? = nil) {
        self.init(frame:.zero)
        self.configure(model: model)
        self.action = action
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupSubviews()
    }
    
    // MARK: - Setup subviews
    private func setupSubviews() {
        setupInternalButton()
    }
    
    private func setupInternalButton() {
        addSubview(internalButton)
        internalButton.centerHorizontally(to: self)
        internalButton.centerVertically(to: self)
        internalButton.right(toView: self)
        internalButton.left(toView: self)
        internalButton.height(equalTo: CGFloat(ButtonConstant.Small.buttonHeight))
        
        internalButton.topNotSafe(toView: self)
        internalButton.bottomNotSafe(toView: self)
    }
    
    // MARK: - Configuration with ViewModel
    public func configure(model: SmallButtonViewModel) {
        
        
        internalButton.setBorderColor(color: .clear, for: .enabled)
        internalButton.setBorderColor(color: .clear, for: .pressed)
        internalButton.setBorderColor(color: .clear, for: .disable)
        
        internalButton.setBackroundColor(color: model.type.backgroundColor(for: .enabled), for: .enabled)
        internalButton.setBackroundColor(color: model.type.backgroundColor(for: .pressed), for: .pressed)
        internalButton.setBackroundColor(color: model.type.backgroundColor(for: .disable), for: .disable)
        
        self.contentView.configure(model: model.buttonContentModel)
        
        internalButton.setContentConfiguration(model: model.type.stateModel(for: .enabled), for: .enabled)
        internalButton.setContentConfiguration(model: model.type.stateModel(for: .pressed), for: .pressed)
        internalButton.setContentConfiguration(model: model.type.stateModel(for: .disable), for: .disable)
    }
    
    // MARK: - ButtonControl protocol methods
    public func action(handler: ButtonAction?) {
        self.action = handler
    }
    
    // MARK: - Private methods
    @objc
    private func touchUpInside(sender: UIButton) {
        self.action?()
    }
}

// MARK: - UIView Autolayout
extension SmallButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    override public var intrinsicContentSize: CGSize {
        return internalButton.bounds.size
    }
}
