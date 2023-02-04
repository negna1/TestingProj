

import UIKit

class ActionsButtonContentView: UIView {
    
    private var imageContainerWidthConstraint: NSLayoutConstraint!
    private var imageContainerHeightConstraint: NSLayoutConstraint!
    
    private var containerView: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = CGFloat(ButtonConstant.Action.imageTextAmountElementsSpace)
        container.alignment = .center
        container.distribution = .fill
        container.layoutMargins = .zero
        return container
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = ButtonConstant.Action.numberOfLines
        label.textAlignment = .center
        label.font = Brandbook.Font.caption1
        return label
    }()
    
    private lazy var amountTextLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = .green
        label.font = Brandbook.Font.button2
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var imageContainer = UIView()
    
    convenience init(model: ComplexButtonContentViewModel) {
        self.init(frame:.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
        setupView()
        setupContainerView()
        setupImageContainerView()
        setupIconImageView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.leftNotSafe(toView: self)
        //containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.rightNotSafe(toView: self)
        //containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.topNotSafe(toView: self)
        //containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomNotSafe(toView: self)
        //containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func setupImageContainerView() {
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainerWidthConstraint = imageContainer.widthAnchor.constraint(equalToConstant: .zero)
        imageContainerWidthConstraint.isActive = true
        imageContainerHeightConstraint = imageContainer.heightAnchor.constraint(equalToConstant: .zero)
        imageContainerHeightConstraint.isActive = true
        imageContainer.addSubview(iconImageView)
    }
    
    private func setupIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerHorizontally(to: imageContainer)
        //iconImageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        //iconImageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        iconImageView.centerVertically(to: imageContainer)
        //imageContainer.layer.borderWidth = CGFloat(ButtonConstant.Action.imageContainerBorderWidth)
    }
    
    func configure(model:ActionsButtonContentViewModel) {
        
        iconImageView.image = model.image.withRenderingMode(.alwaysTemplate)
        containerView.addArrangedSubview(imageContainer)
        textLabel.text = model.text
        containerView.addArrangedSubview(textLabel)
        
        
        if let amountText = model.amountText {
            amountTextLabel.text = amountText
            containerView.addArrangedSubview(amountTextLabel)
        }
        
        imageContainerWidthConstraint.constant = CGFloat(model.iconContainerSize)
        imageContainerHeightConstraint.constant = CGFloat(model.iconContainerSize)
        imageContainer.layer.cornerRadius = CGFloat(model.iconContainerCornerRadius)
    }
}


extension ActionsButtonContentView: ComplexButtonContentView {
    
    
    func configureState(model: ComplexButtonContentViewModel) {
        if let viewModel = model as? ActionsButtonContentViewStateModel {
            imageContainer.layer.borderColor = viewModel.iconContainerBorderColor.cgColor
            imageContainer.backgroundColor = viewModel.iconContainerColor
            iconImageView.tintColor = viewModel.iconColor
            textLabel.textColor = viewModel.textColor
        }
    }
    
}
