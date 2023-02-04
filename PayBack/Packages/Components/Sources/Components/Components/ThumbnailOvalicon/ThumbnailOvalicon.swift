
import UIKit

public extension ThumbnailOvalicon {
    private typealias Dimensions = ThumbnailOvaliconConsts.Dimensions
}

/**
 This class represents ThumbnailOvalicon component. It can be configured with model - `ThumbnailOvalicon.ViewModel`
 
 ## Usage example ##
     let model = ThumbnailOvalicon.ViewModel(
         type:
             .thumbnail(.init(image: nil, borderColor: .red)))
     let view = ThumbnailOvalicon()
 */

public class ThumbnailOvalicon: UIView {
    
    // MARK: Constraints

    private lazy var imageWidth: NSLayoutConstraint = {
        widthAnchor.constraint(equalToConstant: Dimensions.size.width)
    }()
    
    private lazy var imageHeight: NSLayoutConstraint = {
        heightAnchor.constraint(equalToConstant: Dimensions.size.height)
    }()
    
    private lazy var iconWidth: NSLayoutConstraint = {
        iconImageView.widthAnchor.constraint(equalToConstant: Spacing.M.floatValue)
    }()
    
    private lazy var iconHeight: NSLayoutConstraint = {
        iconImageView.heightAnchor.constraint(equalToConstant: Spacing.M.floatValue)
    }()
    
    // MARK: View Properties
    
    private let thumbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public init(model: ThumbnailOvalicon.ViewModel? = nil) {
        super.init(frame: .zero)
        setup()
        guard let model = model else { return }
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .Circle)
        thumbImageView.roundCorners(by: .Circle)
    }
}

// MARK: configure
extension ThumbnailOvalicon {
    public func configure(with model: ThumbnailOvalicon.ViewModel) {
        setBg(model.size.forImage)
        setIcon(model.size.forIcon)
        switch model.type {
        case .thumbnail(let thumb):
            configureThumbImageView(thumb.image)
            configureBorder(color: thumb.borderColor)
            self.backgroundColor = .clear
        case .ovalicon(let ovalicon):
            configureIconImageView(ovalicon.image, tintColor: ovalicon.tintColor)
            configureBorder(color: ovalicon.borderColor)
            self.backgroundColor = ovalicon.backgroundColor
        }
    }
    
    private func configureThumbImageView(_ image: UIImage?) {
        self.thumbImageView.image = image ?? UIImage(placeholderImageType: .circle)
        self.thumbImageView.isHidden = false
        self.iconImageView.isHidden = true
    }
    
    private func configureIconImageView(_ image: UIImage, tintColor: UIColor) {
        self.iconImageView.image = image.withRenderingMode(.alwaysTemplate)
        self.iconImageView.tintColor = tintColor
        self.thumbImageView.isHidden = true
        self.iconImageView.isHidden = false
    }
    
    private func configureBorder(color: UIColor) {
        layer.borderWidth = Dimensions.borderWidth
        layer.borderColor = color.cgColor
    }
}


// MARK: setup
extension ThumbnailOvalicon {
    
    private func setBg(_ size: CGSize) {
        imageWidth.constant = size.width
        imageHeight.constant = size.height
    }
    
    private func setIcon(_ size: CGSize) {
        iconWidth.constant = size.width
        iconHeight.constant = size.height
    }
    
    private func setup() {
        activateConstraints()
        setupThumbImageView()
        setupIconImageView()
    }
    
    private func activateConstraints() {
        imageWidth.isActive = true
        imageHeight.isActive = true
    }
    
    private func setupThumbImageView() {
        self.addSubview(thumbImageView)
        thumbImageView.stretchLayout()
    }
    
    private func setupIconImageView() {
        self.addSubview(iconImageView)
        iconWidth.isActive = true
        iconHeight.isActive = true
        iconImageView.centerVertically(to: self)
        iconImageView.centerHorizontally(to: self)
    }
}
