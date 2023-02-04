
import Foundation
import UIKit

/* FIXME: Class Name Not Meaningfull.
          Better: ActionButton Is Much Appropriate. */
public class FunctionButtonComponent: UIButton {
    
    // FIXME: Enum ButtonState Cases Should Be Lowercased.
    public var buttonState: ButtonState = .Active { didSet { setupColors() } }
    /* FIXME: 1. Bad Protocol Naming.
              2. Strange Factory. */
    private var viewModel: FunctionButtonComponentViewModelProtocol = FunctionButtonComponentFactory.getViewModel()
    private var iconView: UIImageView!
    private var descriptionLabel: LocalLabel!

    public init(title: String, icon: UIImage) {
        super.init(frame: CGRect.zero)
        commonInit(title, icon)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        let description = titleLabel?.text ?? ""
        let icon = imageView!.image!

        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)

        commonInit(description, icon)
    }

    private func commonInit(_ description: String, _ icon: UIImage) {
        createIconView(icon.withRenderingMode(.alwaysTemplate))
        createDescriptionLabel(description)
        configureButton(createContentView())
    }
    
    /* FIXME: 1.Bad Function Name.
              Function Name Not Defining The Actual.*/
    private func createIconView(_ icon: UIImage) {
        /*  FIXME: Creating ImageView Instance And After Assigning Local Instance To The Property.
                   Better: self.iconView = UIImageView(image: icon) */
        let iconView = UIImageView(image: icon)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: viewModel.layout.iconWidth).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: viewModel.layout.iconHeight).isActive = true
        self.iconView = iconView
    }

    private func createDescriptionLabel(_ description: String) {
        /*  FIXME: Creating LocalLabel Instance And After Assigning Local Instance To The Property.
                   Better: self.descriptionLabel = LocalLabel() */
        let descriptionLabel = LocalLabel()
        descriptionLabel.text = description
        descriptionLabel.font = viewModel.layout.font
        descriptionLabel.textAlignment = .center
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel = descriptionLabel
    }

    /* FIXME: 1. SRP Violation.
              2. Bad Function Name. Not Only Creating UIView But Also Returning It. */
    private func createContentView() -> UIView {
        let contentView = UIView()
        contentView.isUserInteractionEnabled = false
        contentView.addSubview(iconView)
        contentView.addSubview(descriptionLabel)

        // FIXME: Why Closure ?
        let largest = { () -> UIView in
            if descriptionLabel.intrinsicContentSize.width > viewModel.layout.iconWidth {
                return descriptionLabel
            }
            return iconView
        }()

        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: largest.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: largest.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: iconView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),

            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -viewModel.layout.spacing)
        ])

        return contentView
    }

    
    private func configureButton(_ contentView: UIView) {
        addSubview(contentView)

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: viewModel.layout.minWidth),
            widthAnchor.constraint(lessThanOrEqualToConstant: viewModel.layout.maxWidth),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -viewModel.layout.contentLeading),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: viewModel.layout.contentTrailing),
            topAnchor.constraint(equalTo: contentView.topAnchor, constant: -viewModel.layout.contentTop),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: viewModel.layout.contentBottom)
        ])
    }

    /* FIXME: Inappropriate Place For Rounding Corners And Setting Up Colors.
              Called Multiple Times. */
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: viewModel.layout.cornerRadius)
        setupColors()
    }

    private func setupColors() {
        backgroundColor = viewModel.backgroundColor(forState: buttonState)
        descriptionLabel?.textColor = viewModel.titleColor(forState: buttonState)
        iconView?.tintColor = viewModel.iconColor(forState: buttonState)
    }

    // MARK: Touch Events
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if buttonState != .Disabled { buttonState = .Pressed }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if buttonState != .Disabled { buttonState = .Active }
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if buttonState != .Disabled { buttonState = .Active }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
}

extension FunctionButtonComponent: FunctionButtonProtocol {

    public func setContentTitle(title: String) {
        descriptionLabel.text = title
    }

    public func setContentIcon(iconName: String) {
        iconView.image = UIImage(named: iconName)!.withRenderingMode(.alwaysTemplate)
    }
}
