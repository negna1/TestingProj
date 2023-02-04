

import UIKit


public class PrimaryButton: UIView, LoadableButtonControl  {
    
    // MARK: - Internal constants
    static let pixelRect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
    
    // MARK: - Private properties
    private lazy var internalButton: UIButton = {
        let button = LocalButton(type: .custom)
        button.addTarget(self, action: #selector(toucshesUpInside), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var loadingView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.add(loadingAnimation, forKey: ButtonConstant.Primary.loadingAnimationKey)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loadingAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: ButtonConstant.Primary.loadingAnimationKeyPath)
        animation.fromValue = Double.zero
        animation.toValue =  ButtonConstant.rotatingLoaderRotation
        animation.duration = ButtonConstant.rotatingLoadingAnimationDuration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false

        return animation
    }()
    
    private var action: ButtonAction?
    private var heightConstraint: NSLayoutConstraint!
    private var loaderWidthConstraint: NSLayoutConstraint!
    private var loaderHeightConstraint: NSLayoutConstraint!
    
    // FIXME: Group public vars and funcs together
    // MARK: - LoadableButtonControl protocol properties
    public var isLoading: Bool = false {
        didSet {
            self.updateLoader()
            self.internalButton.isEnabled = !isLoading
        }
    }
    // FIXME: Group public vars and funcs together
    public var isEnabled: Bool {
        get { internalButton.isEnabled }
        set { internalButton.isEnabled = newValue }
    }
    
    // MARK: - Initializers
    public convenience init(model: PrimaryButtonViewModel, action: ButtonAction? = nil) {
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
        addSubview(internalButton)
        
        internalButton.leftNotSafe(toView: self)
        //internalButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        internalButton.rightNotSafe(toView: self)
        //internalButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        internalButton.centerVertically(to: self)
        internalButton.topNotSafe(toView: self)
        internalButton.bottomNotSafe(toView: self)
        //internalButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        heightConstraint = internalButton.heightAnchor.constraint(equalToConstant: .zero)
        heightConstraint.isActive = true
        
        loaderWidthConstraint = loadingView.widthAnchor.constraint(equalToConstant: .zero)
        loaderWidthConstraint.isActive = true
        loaderHeightConstraint = loadingView.heightAnchor.constraint(equalToConstant: .zero)
        loaderHeightConstraint.isActive = true
        
//        internalButton.contentEdgeInsets = UIEdgeInsets(left: CGFloat(ButtonConstant.Primary.leftRightOffset),
//                                                        right: CGFloat(ButtonConstant.Primary.leftRightOffset) )
    }
    
    // MARK: - Configuration with ViewModel
    public func configure(model: PrimaryButtonViewModel) {
        
        internalButton.layer.cornerRadius = model.constants.cornerRadius
        
        heightConstraint.constant = model.constants.height
        
        internalButton.setTitle(model.title, for: .normal)
        internalButton.setTitleColor(model.constants.textColors[.enabled], for: .normal)
        internalButton.setTitleColor(model.constants.textColors[.pressed], for: .highlighted)
        internalButton.setTitleColor(model.constants.textColors[.disable], for: .disabled)
        
        internalButton.titleLabel?.font = model.constants.textFont
        
        setBackgroundColor(model.constants.backgroundColors[.enabled]!, for: .normal)
        setBackgroundColor(model.constants.backgroundColors[.pressed]!, for: .highlighted)
        setBackgroundColor(model.constants.backgroundColors[.disable]!, for: .disabled)
        
        
        loadingView.image = model.constants.loadingImage
        
        loaderWidthConstraint.constant = model.constants.loaderSize
        loaderHeightConstraint.constant = model.constants.loaderSize
        
    }

    // MARK: - LoadableButtonControl protocol methods
    public func action(handler: ButtonAction?) {
        self.action = handler
    }
    
    // MARK: - Private methods
    private func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let rect = PrimaryButton.pixelRect
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context?.setFillColor(color.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        internalButton.setBackgroundImage(image, for: state)
    }
    
    @objc
    private func toucshesUpInside(sender: UIButton) {
        self.action?()
    }
    
    private func updateLoader() {
        if self.isLoading {
            addSubview(loadingView)
            loadingView.centerYAnchor.constraint(equalTo: internalButton.centerYAnchor).isActive = true
            loadingView.trailingAnchor.constraint(equalTo: internalButton.trailingAnchor,
                                                  constant: -CGFloat(ButtonConstant.Primary.loaderOffset)).isActive = true
        } else {
            loadingView.removeFromSuperview()
        }
    }
}

// MARK: - UIView Autolayout
extension PrimaryButton {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    override public var intrinsicContentSize: CGSize {
        return internalButton.bounds.size
    }
}
