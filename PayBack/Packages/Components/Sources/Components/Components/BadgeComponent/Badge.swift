

import UIKit

public class Badge: UIView {
    
    private typealias Size = BadgeConsts.Size
    private typealias Font = BadgeConsts.Font
    private typealias Color = BadgeConsts.Color
        
    private var width: NSLayoutConstraint?
    private var height: NSLayoutConstraint?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.title
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.textColor = Color.textColor
        return label
    }()
    
    public init(with model: BadgeModel? = nil) {
        super.init(frame: .zero)
        setup()
        translatesAutoresizingMaskIntoConstraints = false
        guard let model = model else { return }
        configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: setup
extension Badge {
    private func setup() {
        setupTitleLabel()
        layer.borderWidth = Size.borderWidth
        layer.masksToBounds = true
        width = widthAnchor.constraint(equalToConstant: .zero)
        height = heightAnchor.constraint(equalToConstant: .zero)
        width?.isActive = true
        height?.isActive = true
    }
}

// MARK: configure
extension Badge {
    public func configure(with model: BadgeModel) {
        backgroundColor = model.style.backgroundColor
        width?.constant = model.dimension.size.width
        height?.constant = model.dimension.size.height
        configureBorder(with: model)
        setTitle(model.attributedTitle)
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.centerHorizontally(to: self)
        titleLabel.centerVertically(to: self)
    }
    
    private func setTitle(_ title: NSAttributedString) {
        titleLabel.attributedText = title
    }
    
    private func configureBorder(with model: BadgeModel) {
        layer.cornerRadius = model.dimension.cornerRadius
        layer.borderColor = Color.border?.cgColor
    }
}
