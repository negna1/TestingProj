

import UIKit

/**
## Usage example ##
     let button = ActionsButton()
     button.configure(model: .card(icon: image ,title: "submit"))
     
     button.action {
         print("Clicked")
     }
 
*/
public class ActionsButton: UIView, ButtonControl {
    
    private var action: ButtonAction?
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    
    private var contentView = ActionsButtonContentView()
    
    private lazy var internalButton: ComplexButton = {
        let button = ComplexButton(contentView: self.contentView)
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        return button
    }()
    
    public var isEnabled: Bool {
        get { return internalButton.isEnabled }
        set { internalButton.isEnabled = newValue }
    }
    
    public convenience init(model: ActionsButtonModel, action: ButtonAction? = nil)  {
        self.init(frame:.zero)
        self.configure(model: model)
        self.action = action
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.addSubview(internalButton)
        internalButton.translatesAutoresizingMaskIntoConstraints = false
        internalButton.centerVertically(to: self)
        //internalButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        internalButton.centerHorizontally(to: self)
        //internalButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        heightConstraint = internalButton.heightAnchor.constraint(greaterThanOrEqualToConstant: .zero)
        heightConstraint.isActive = true
        widthConstraint = internalButton.widthAnchor.constraint(equalToConstant: .zero)
        widthConstraint.isActive = true
    }
    
    @objc
    private func touchUpInside(sender: ComplexButton) {
        self.action?()
    }
    
    public func configure(model: ActionsButtonModel) {
        
        self.widthConstraint.constant = model.constants.width
        self.heightConstraint.constant = model.constants.height
        
        self.contentView.configure(model: model.constants.contentViewModel(icon: model.icon, text: model.text))
        
        self.internalButton.setContentConfiguration(model: model.constants.stateModel(for: .enabled), for: .enabled)
        self.internalButton.setContentConfiguration(model: model.constants.stateModel(for: .pressed), for: .pressed)
        self.internalButton.setContentConfiguration(model: model.constants.stateModel(for: .disable), for: .disable)

    }
    
    public func action( handler: ButtonAction?) {
        self.action = handler
    }
}

// MARK: - UIView Autolayout
extension ActionsButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    override public var intrinsicContentSize: CGSize {
        return internalButton.bounds.size
    }
}
