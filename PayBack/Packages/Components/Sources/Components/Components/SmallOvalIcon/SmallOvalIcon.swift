
import UIKit

public class SmallOvalIcon: UIControl {
    
    private typealias Colors = SmallOvalIconConstants.Colors
    private typealias Dimensions = SmallOvalIconConstants.Dimensions
    
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                configureState(.pressed)
            } else {
                configureState(.normal)
            }
        }
    }
        
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Initializes and returns component with or without given model
    ///
    /// When initialized without model component can be configured by `configure(with:)` method
    
    public init(model: SmallOvalIconModel? = nil) {
        super.init(frame: .zero)
        self.imageView.image = model?.image?.withRenderingMode(.alwaysTemplate)
        if let iconState = model?.iconState {
            configureState(iconState)
        }
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        elevate(level: .Thirty, cornerRadius: .Circle)
    }
    
    //MARK: View configuration
    
    
    public func configure(with model: SmallOvalIconModel) {
        self.imageView.image = model.image?.withRenderingMode(.alwaysTemplate)
        configureState(model.iconState)
    }
    
    public func configureState(_ iconState: SmallOvalIconState) {
        self.isEnabled = iconState.isEnabled
        configureColors(with: iconState)
    }
    
    private func configureColors(with iconState: SmallOvalIconState) {
        self.imageView.tintColor = iconState.colors.iconTintColor
        self.backgroundColor = iconState.colors.backgroundColor
    }
    
    //MARK: View setup
    
    private func setupMainConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.width(equalTo: SmallOvalIconConstants.Dimensions.size.width)
        self.height(equalTo: SmallOvalIconConstants.Dimensions.size.height)
    }
    
    private func setupView() {
        setupMainConstraints()
        setupImageView()
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        imageView.width(equalTo: SmallOvalIconConstants.Dimensions.imageViewSize.width)
        imageView.height(equalTo: SmallOvalIconConstants.Dimensions.imageViewSize.height)
        imageView.centerVertically(to: self)
        imageView.centerHorizontally(to: self)
    }
    
}
