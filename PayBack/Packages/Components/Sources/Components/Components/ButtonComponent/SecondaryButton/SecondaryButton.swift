

import UIKit

/**

## Usage example ##
     let button = SecondaryButton()
     let image = ImageBook.image(named:"icons24AccountsAccounts")!
     let model = SecondaryButtonViewModel.solidTextIconBadge(title: "edit dashboard",
                                                             icon: image,
                                                             badgeModel: .init(.info, 5))
     button.action {
         print("Clicked")
     }
     
     button.configure(model: model)
*/
public class SecondaryButton: UIView, ButtonControl {
    
    // MARK: - Internal properties
    internal var action: ButtonAction?
    
    private var contentView = IconBadgeButtonContentView()
    
    internal lazy var internalButton: ComplexButton = {
        let button = ComplexButton(contentView: self.contentView)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ButtonControl protocol properties
    public var isEnabled: Bool {
        get { return internalButton.isEnabled }
        set { internalButton.isEnabled = newValue }
    }
    
    // MARK: - Initializers
    public convenience init(model: SecondaryButtonViewModel, action: ButtonAction? = nil)  {
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
    func setupSubviews() {
        setupInternalButton()
    }
    
    private func setupInternalButton() {
        self.addSubview(internalButton)
        internalButton.centerVertically(to: self)
        internalButton.leftNotSafe(toView: self)
        internalButton.rightNotSafe(toView: self)
        internalButton.topNotSafe(toView: self)
        internalButton.bottomNotSafe(toView: self)
        internalButton.height(equalTo: CGFloat(ButtonConstant.Secondary.buttonHeight))
        
        internalButton.topNotSafe(toView: self)
        internalButton.bottomNotSafe(toView: self)
        
        internalButton.cornerRadius = CGFloat(ButtonConstant.Secondary.cornerRadius)
    }
    
    // MARK: - Configuration with ViewModel
    public func configure(model: SecondaryButtonViewModel) {
        
        internalButton.borderWidth = model.type.borderWidth
        internalButton.borderStyle = model.type.borderStyle
        
        internalButton.setBorderColor(color: model.type.borderColor(for: .enabled), for: .enabled)
        internalButton.setBorderColor(color: model.type.borderColor(for: .pressed), for: .pressed)
        internalButton.setBorderColor(color: model.type.borderColor(for: .disable), for: .disable)
        
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
    private func touchUpInside(sender: ComplexButton) {
        self.action?()
    }
}

// MARK: - UIView Autolayout
extension SecondaryButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    override public var intrinsicContentSize: CGSize {
        return internalButton.bounds.size
    }
}
