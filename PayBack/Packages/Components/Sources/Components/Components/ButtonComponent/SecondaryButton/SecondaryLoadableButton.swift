

import UIKit


public class SecondaryLoadableButton: SecondaryButton, LoadableButtonControl {
    
    // MARK: - Private properties
    private lazy var loadingAnimation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: ButtonConstant.Secondary.loadingAnimationKeyPath)
        animation.fromValue = Double.zero
        animation.toValue =  ButtonConstant.rotatingLoaderRotation
        animation.duration = ButtonConstant.rotatingLoadingAnimationDuration
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false

        return animation
    }()
    
    lazy var loadingView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.add(loadingAnimation, forKey: ButtonConstant.Secondary.loadingAnimationKey)
        return imageView
    }()
    
    // MARK: - LoadableButtonControl protocol properties
    public var isLoading: Bool = false {
        didSet {
            self.updateLoader()
            self.internalButton.isEnabled = !isLoading
        }
    }
    
    // MARK: - Initializers
    public convenience init(model: SecondaryLoadableButtonViewModel, action: ButtonAction? = nil) {
        self.init(frame:.zero)
        self.configure(model: model)
        self.action = action
    }
    
    // MARK: - Setup subviews
    override func setupSubviews() {
        super.setupSubviews()
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Configuration with ViewModel
    public func configure(model: SecondaryLoadableButtonViewModel) {
        
        self.configure(model: model.buttonViewModel)
        loadingView.image = model.buttonViewModel.type.loadingImage
    }
    
    // MARK: - Private methods
    private func updateLoader() {
        if self.isLoading {
            addSubview(loadingView)
            loadingView.centerYAnchor.constraint(equalTo: internalButton.centerYAnchor).isActive = true
            loadingView.trailingAnchor.constraint(
                equalTo: internalButton.trailingAnchor,
                constant: CGFloat(-ButtonConstant.Secondary.Loadable.loadingViewOffset)).isActive = true
        } else {
            loadingView.removeFromSuperview()
        }
    }
}
