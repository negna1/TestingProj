
import UIKit

/// This class represents OvalActionButton component. It can be configured with model - `OvalActionButtonViewModel`
///  ## Usage example ##
///     let model = OvalActionButton.ViewModel(
///                     image: UIImage(named: "icons24SystemRetry"),
///                     title: "შოთა ტატუნაშვილი",
///                     amount: "125.65 ₾",
///                     type: .icon)
///     let actionButton = OvalActionButton(model: model)
///
///
///  Check out design on [zeplin](https://zpl.io/bPJ98rL)
///

public class OvalActionButton: UIView {
    
    private var onTap: ((OvalActionButton) -> Void)?
    private lazy var ovalActionButtonControl: OvalActionButtonControl = {
        let control = OvalActionButtonControl()
        control.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    public init(model: OvalActionButton.ViewModel? = nil) {
        super.init(frame: .zero)
        setupView()
        if let model = model {
            configure(with: model)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    @objc private func didTap() {
        onTap?(self)
    }
    
    //MARK: View configuration
    
    public func configure(with model: OvalActionButton.ViewModel) {
        self.onTap = model.onTap
        ovalActionButtonControl.configure(with: model)
    }
    
    //MARK: View setup
    
    func setupView() {
        self.addSubview(ovalActionButtonControl)
        ovalActionButtonControl.stretchLayout()
    }
}

public class OvalActionButtonControl: UIControl {
    
    private typealias Demensions = OvalActionButton.Constants.Demensions
    private typealias Fonts = OvalActionButton.Constants.Fonts
    private typealias Colors = OvalActionButton.Constants.Colors
    private typealias Images = OvalActionButton.Constants.Images
    
    private let imageContainerView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: Demensions.ImageContainer.size))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.width(equalTo: Demensions.ImageContainer.size.width)
        view.height(equalTo: Demensions.ImageContainer.size.height)
        view.layer.borderWidth = Demensions.ImageContainer.borderWidth
        view.layer.borderColor = Colors.border.cgColor
        view.roundCorners(by: .Circle)
        return view
    }()
    
    private let closeIconContainerView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: Demensions.CloseIconContainer.size))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.width(equalTo: Demensions.CloseIconContainer.size.width)
        view.height(equalTo: Demensions.CloseIconContainer.size.height)
        view.backgroundColor = Colors.closeBackground
        view.roundCorners(by: .Circle)
        return view
    }()
    
    private let closeIcon: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.closeIcon
        imageView.tintColor = Colors.closeIcon
        return imageView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.title
        label.font = Fonts.title
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private let amountLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.amount
        label.font = Fonts.amount
        label.textAlignment = .center
        return label
    }()
    
    /// Initializes and returns component with or without given model
    ///
    /// When initialized without model component can be configured by `configure(with:)` method
    
    public init(model: OvalActionButton.ViewModel? = nil) {
        super.init(frame: .zero)
        setupView()
        if let model = model {
            configure(with: model)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: View configuration
    
    public func configure(with model: OvalActionButton.ViewModel) {
        if let image = model.image {
            self.imageView.image = image.withRenderingMode(model.type.renderingMode)
        } else {
            self.imageView.image = model.type.placeholderImage
        }
        self.imageView.tintColor = model.type.tintColor
        self.imageView.stretchLayout(with: model.type.imagePadding)
        self.titleLabel.text = model.title
        self.amountLabel.text = model.amount
    }
    
    //MARK: View setup
    
    private func setupView() {
        self.width(equalTo: Demensions.width)
        self.addSubview(imageContainerView)
        setupImageContainerConstraints()
        self.imageContainerView.addSubview(imageView)
        self.addSubview(titleLabel)
        setupTitleLabelConstraints()
        self.addSubview(amountLabel)
        setupAmountLabelConstraints()
        self.addSubview(closeIconContainerView)
        self.setupCloseContainerViewConstraints()
        self.closeIconContainerView.addSubview(closeIcon)
        closeIcon.stretchLayout(with: Demensions.CloseIcon.padding)
    }
    
    private func setupImageContainerConstraints() {
        imageContainerView.top(toView: self)
        imageContainerView.centerHorizontally(to: self)
    }
    
    func setupCloseContainerViewConstraints() {
        closeIconContainerView.top(toView: self)
        closeIconContainerView.relativeLeft(toView: imageContainerView, constant: Demensions.CloseIconContainer.leftConstraint)
    }
    
    private func setupTitleLabelConstraints() {
        titleLabel.relativeTop(toView: imageContainerView, constant: Demensions.TitleLabel.topConstraint)
        titleLabel.left(toView: self)
        titleLabel.right(toView: self)
    }
    
    private func setupAmountLabelConstraints() {
        amountLabel.relativeTop(toView: titleLabel, constant: Demensions.AmountLabel.topConstraint)
        amountLabel.left(toView: self)
        amountLabel.right(toView: self)
        amountLabel.bottom(toView: self)
    }
}
