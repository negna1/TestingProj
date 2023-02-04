

import UIKit

/**

## Usage example ##
     let button = TextButtonComponent()
     let icon = ImageBook.image(named:"icons24SystemInfoOutline")!
     let model = TextButtonComponentViewModel.smallIconText(icon: icon,
                                                            title: "forgot password?")
     button.action {
         print("Clickedd")
     }
     
     button.configure(model: model)
*/
public class TextButtonComponent: UIView, ButtonControl {
    
    // MARK: - Private properties
    private lazy var internalButton: UIButton = {
        let button = LocalButton(type: .custom)
        button.addTarget(self, action: #selector(toucshesUpInside), for: .touchUpInside)
        return button
    }()
    
    private var action: ButtonAction?
    private var heightConstraint: NSLayoutConstraint!
    
    // MARK: - ButtonControl protocol properties
    public var isEnabled: Bool {
        get { internalButton.isEnabled }
        set { internalButton.isEnabled = newValue }
    }
    
    // MARK: - Initializers
    public convenience init(model: TextButtonComponentViewModel, action: ButtonAction? = nil) {
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
        addSubview(internalButton)
        internalButton.translatesAutoresizingMaskIntoConstraints = false
        internalButton.leftNotSafe(toView: self)
        //internalButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        internalButton.rightNotSafe(toView: self)
        //internalButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        internalButton.centerVertically(to: self)
        //internalButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        heightConstraint = internalButton.heightAnchor.constraint(equalToConstant: .zero)
        heightConstraint.isActive = true
        
        internalButton.topNotSafe(toView: self)
        internalButton.bottomNotSafe(toView: self)
        
        
    }
    
    // MARK: - Configuration with ViewModel
    public func configure(model: TextButtonComponentViewModel) {
        
        internalButton.backgroundColor = .white
        internalButton.layer.masksToBounds = true
        
//        internalButton.contentEdgeInsets = UIEdgeInsets(left: model.type.leftRightInset,
//                                                        right: model.type.leftRightInset)
//        internalButton.imageEdgeInsets = UIEdgeInsets(left: model.type.imageOffset)
        
        heightConstraint.constant = CGFloat(ButtonConstant.Text.buttonHeight)
        
        internalButton.setTitle(model.title, for: .normal)
        internalButton.setTitleColor(model.type.textColor(for: .enabled), for: .normal)
        internalButton.setTitleColor(model.type.textColor(for: .pressed), for: .highlighted)
        internalButton.setTitleColor(model.type.textColor(for: .disable), for: .disabled)
        
        internalButton.titleLabel?.font = model.type.textFont
        

        internalButton.setImage(tinted(image: model.icon, color:model.type.textColor(for: .enabled)), for: .normal)
        internalButton.setImage(tinted(image: model.icon, color:model.type.textColor(for: .pressed)), for: .highlighted)
        internalButton.setImage(tinted(image: model.icon, color:model.type.textColor(for: .disable)), for: .disabled)
    }
    
    // MARK: - ButtonControl protocol methods
    public func action(handler: ButtonAction?) {
        self.action = handler
    }
    
    // MARK: - Private methods
    //TODO: Move this in to ImageBook
    private func tinted(image: UIImage?, color: UIColor) -> UIImage? {
        guard let template = image?.withRenderingMode(.alwaysTemplate)  else { return image }
        let imageView = UIImageView(image: template)
        imageView.tintColor = color
        
        UIGraphicsBeginImageContext(template.size)
        if let context = UIGraphicsGetCurrentContext() {
            imageView.layer.render(in: context)
            let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return tintedImage
        } else {
            return image
        }
    }
    
    @objc
    private func toucshesUpInside(sender: UIButton) {
        self.action?()
    }
}

// MARK: - UIView Autolayout
extension TextButtonComponent {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    override public var intrinsicContentSize: CGSize {
        return internalButton.bounds.size
    }
}
