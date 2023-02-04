
import UIKit

/**

 ## Usage example ##
      let model = TextBadge.ViewModel(
                        backgroundColor: .red,
                        type: .single(
                            text: .init(
                              title: "საცდელი ტექსტი საცდელი ტექსტი",
                              color: .green)))
      let view = TextBadge(with: model)

*/
public class TextBadge: UIView {
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        return stack
    }()
    
    private let textsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private let captionLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: LocalLabel = {
        let label = LocalLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.width(equalTo: Spacing.M.floatValue)
        imageView.height(equalTo: Spacing.M.floatValue)
        return imageView
    }()
    
    private lazy var contentStackLeadingConstraint: NSLayoutConstraint! = {
        let constraint = containerStack.leadingAnchor.constraint(equalTo: leadingAnchor)
        constraint.isActive = true
        return constraint
    }()
    
    private lazy var contentStackTopConstraint: NSLayoutConstraint! = {
        let constraint = containerStack.topAnchor.constraint(equalTo: self.topAnchor)
        constraint.isActive = true
        return constraint
    }()
    
    private lazy var contentStackTrailingConstraint: NSLayoutConstraint! = {
        let constraint = containerStack.rightAnchor.constraint(equalTo: self.rightAnchor)
        constraint.isActive = true
        return constraint
    }()
    
    private lazy var contentStackBottomConstraint: NSLayoutConstraint! = {
        let constraint = containerStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        constraint.isActive = true
        return constraint
    }()
    
    public init(with model: TextBadge.ViewModel? = nil) {
        super.init(frame: .zero)
        setup()
        guard let model = model else {return}
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

}

// MARK: configure
extension TextBadge {
    public func configure(with model: TextBadge.ViewModel) {
        backgroundColor = model.backgroundColor
        switch model.type {
        case .single(let title):
            show(caption: false, descriptin: false, icon: false)
            configureTitleLabel(text: title)
            configureCorners(with: .Twenty)
            titleLabel.font = Font.singleText
            textsStack.alignment = .leading
        case let .double(title, description):
            show(caption: false, descriptin: true, icon: false)
            configureTitleLabel(text: title)
            configureDescription(description: description)
            configureCorners(with: .Thirty)
            titleLabel.font = Font.doubleText
            descriptionLabel.font = Font.description
            textsStack.alignment = .leading
        case .icon(let title, let icon):
            show(caption: false, descriptin: false, icon: true)
            configureTitleLabel(text: title)
            configureIconImageView(with: icon)
            configureCorners(with: .Thirty)
            titleLabel.font = Font.description
            textsStack.alignment = .leading
        case .uppercase(let title):
            show(caption: false, descriptin: false, icon: false)
            configureTitleLabel(text: title)
            configureCorners(with: .Ten)
            titleLabel.font = Font.upercase
            textsStack.alignment = .leading
        case .doubleWithCaption(let caption, let title, let description):
            show(caption: true, descriptin: true, icon: false)
            configureCaption(text: caption)
            configureTitleLabel(text: title)
            configureDescription(description: description)
            configureCorners(with: .Thirty)
            captionLabel.font = Font.caption
            titleLabel.font = Font.doubleWithCaptionTitle
            descriptionLabel.font = Font.singleText
            titleLabel.textAlignment = .left
            textsStack.alignment = .leading
            textsStack.setCustomSpacing(Spacing.XS3.floatValue, after: captionLabel)
        case .caption(let caption, let title, let alignment):
            show(caption: true, descriptin: false, icon: false)
            configureCaption(text: caption)
            configureTitleLabel(text: title)
            configureCorners(with: .Thirty)
            captionLabel.font = Font.caption
            titleLabel.textAlignment = .center
            titleLabel.font = Font.singleText
            textsStack.alignment = alignment == .center ? .center : .leading
            textsStack.setCustomSpacing(TextBadgeConsts.Padding.captionSpacing, after: captionLabel)
            containerStack.setCustomSpacing(Spacing.XL.floatValue, after: textsStack)
        }
        configureSpacing(with: model)
    }
    
    func configureCaption(text: TextBadge.ViewModel.Text) {
        captionLabel.text = text.title
        captionLabel.textColor = text.color
    }

    func configureTitleLabel(text: TextBadge.ViewModel.Text) {
        titleLabel.text = text.title
        titleLabel.textColor = text.color
    }
    
    func configureDescription(description: TextBadge.ViewModel.Text) {
        descriptionLabel.text = description.title
        descriptionLabel.textColor = description.color
    }
    
    func configureIconImageView(with icon: TextBadge.ViewModel.Icon) {
        iconImageView.image = icon.icon
        iconImageView.tintColor = icon.tint
    }
    
    func show(caption: Bool, descriptin: Bool, icon: Bool) {
        captionLabel.isHidden = !caption
        descriptionLabel.isHidden = !descriptin
        iconImageView.isHidden = !icon
    }
    
    func configureCorners(with radius: CornerRadius) {
        roundCorners(by: radius)
    }
    
    func configureSpacing(with model: TextBadge.ViewModel) {
        contentStackLeadingConstraint.constant = model.type.leadingTrailing
        contentStackTrailingConstraint.constant = -model.type.leadingTrailing
        contentStackTopConstraint.constant = model.type.topBottom
        contentStackBottomConstraint.constant = -model.type.topBottom
    }
}

// MARK: setup
extension TextBadge {
    private func setup() {
        setupContainerStack()
        setupIconImageView()
        setupTextsStack()
        setupDescriptionLabel()
    }

    private func setupContainerStack() {
        addSubview(containerStack)
    }
    
    private func setupTextsStack() {
        containerStack.addArrangedSubview(textsStack)
        textsStack.addArrangedSubview(captionLabel)
        textsStack.addArrangedSubview(titleLabel)
        containerStack.setCustomSpacing(Spacing.XL3.floatValue, after: textsStack)
    }
    
    private func setupIconImageView() {
        containerStack.addArrangedSubview(iconImageView)
        containerStack.setCustomSpacing(Spacing.XS.floatValue, after: iconImageView)
    }
    
    private func setupDescriptionLabel() {
        containerStack.addArrangedSubview(descriptionLabel)
    }
}
