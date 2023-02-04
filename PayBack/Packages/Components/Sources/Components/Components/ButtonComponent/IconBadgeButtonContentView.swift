

import UIKit

class IconBadgeButtonContentView: UIView {
    
    private var minLeadingSpaceConstraint: NSLayoutConstraint!
    private var minTrailingSpaceConstraint: NSLayoutConstraint!
    
    private var iconTextSpaceViewWidthConstraint: NSLayoutConstraint!
    private var textBadgeSpaceViewWidthConstraint: NSLayoutConstraint!
    
    public var containerView = UIStackView()
    
    public lazy var iconTextSpaceView: UIView = {
        let container = UIView()
        return container
    }()
    
    public lazy var textBadgeSpaceView: UIView = {
        let container = UIView()
        return container
    }()
    
    public lazy var textLabel: LocalLabel = {
        var label = LocalLabel()
        label.textAlignment = .center
        return label
    }()
    
    public lazy var imageView: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    public lazy var badgeView: Badge = {
        var badge = Badge()
        return badge
    }()
    
    convenience init(model: ComplexButtonContentViewModel) {
        self.init(frame:.zero)
        configureState(model: model)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        
        setupView()
        setupContainerView()
        setupIconTextSpaceView()
        setupTextBadgeSpaceView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
    }
    
    private func setupContainerView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        minLeadingSpaceConstraint = containerView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor)
        minLeadingSpaceConstraint.isActive = true
        
        minTrailingSpaceConstraint = containerView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        minTrailingSpaceConstraint.isActive = true
        
//        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        containerView.centerHorizontally(to: self)
//        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.centerVertically(to: self)
        imageView.width(equalTo: CGFloat(ButtonConstant.Small.IconText.iconSize))
        imageView.height(equalTo: CGFloat(ButtonConstant.Small.IconText.iconSize))
    }
    
    private func setupIconTextSpaceView() {
        iconTextSpaceView.translatesAutoresizingMaskIntoConstraints = false
        iconTextSpaceViewWidthConstraint = iconTextSpaceView.widthAnchor.constraint(equalToConstant: .zero)
        iconTextSpaceViewWidthConstraint.isActive = true
    }
    
    private func setupTextBadgeSpaceView() {
        textBadgeSpaceView.translatesAutoresizingMaskIntoConstraints = false
        textBadgeSpaceViewWidthConstraint = textBadgeSpaceView.widthAnchor.constraint(equalToConstant:.zero)
        textBadgeSpaceViewWidthConstraint.isActive = true
    }
    
    public func configure(model: IconBadgeButtonContentViewModel) {
        
        var subviews: [UIView] = []
        
        if let image = model.iconImage {
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            subviews.append(imageView)
            subviews.append(iconTextSpaceView)
            iconTextSpaceViewWidthConstraint.constant = model.iconDistance
        }
        
        textLabel.text = model.title
        textLabel.font = model.textFont
        subviews.append(textLabel)
        
        if let budgeModel = model.badgeModel {
            badgeView.configure(with: budgeModel)
            subviews.append(textBadgeSpaceView)
            subviews.append(badgeView)
            textBadgeSpaceViewWidthConstraint.constant = model.badgeDistance
        }
        
       
        let arrangedSubviews = model.iconBadgeInverted ? subviews.reversed() : subviews
        
        containerView.removeAllSubviews()
        arrangedSubviews.forEach { view in
            containerView.addArrangedSubview(view)
        }
        
        minLeadingSpaceConstraint.constant = model.minContentHorizontalPaddings
        minTrailingSpaceConstraint.constant = -model.minContentHorizontalPaddings
    }
}

extension IconBadgeButtonContentView: ComplexButtonContentView {
    
    
    func configureState(model: ComplexButtonContentViewModel) {
        if let viewModel = model as? IconBadgeButtonContentViewStateModel {

            imageView.tintColor = viewModel.textColor
            textLabel.textColor = viewModel.textColor
            badgeView.alpha = CGFloat(viewModel.badgeAlpha)
        }
    }
    
}
