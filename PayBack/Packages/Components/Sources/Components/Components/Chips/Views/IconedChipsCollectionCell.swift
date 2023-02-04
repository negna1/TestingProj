

import UIKit

class IconedChipsCollectionViewCell: UICollectionViewCell {
    
    override var reuseIdentifier: String? { "IconedChipsCollectionViewCell" }
    
    override var isHighlighted: Bool {
        didSet {
            guard state == .enabled else { return }
            if isHighlighted {
                contentView.backgroundColor =  UIColor.orange
            } else {
                contentView.backgroundColor =  UIColor.orange
            }
        }
    }
    
    var state: IconedChipsCellState = .disabled

    private let icon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "doc.text.image")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
     
    private let bottomLabel: LocalLabel = {
        let lbl = LocalLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(bottomLabel)
        stackView.spacing = .zero
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.roundCorners(by: .Circle)
        icon.roundCorners(by: .Circle)
//        iconContainer.roundCorners(by: .Circle)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        insertSubviews()
        setupConstraints()
    }
    
    private func insertSubviews() {
//        iconContainer.addSubview(icon)
        contentView.addSubview(icon)
        contentView.addSubview(labelsStackView)
        labelsStackView.addSubview(textLabel)
        setupBorder()
    }
    
    private func setupConstraints() {
        icon.left(toView: contentView, constant: Spacing.XS.floatValue)
        icon.centerVertically(to: contentView)
        icon.width(equalTo: 24)
        icon.height(equalTo: 24)
        
        labelsStackView.relativeLeft(toView: icon, constant: Spacing.XS2.floatValue)
        labelsStackView.centerVertically(to: contentView)
        labelsStackView.right(toView: contentView, constant: Spacing.M.floatValue)
    }
    
    private func setupBorder() {
        contentView.layer.borderWidth = 1
//        contentView.layer.borderColor = color(.Primary, .Solid, .Shade500).cgColor
    }
    
    private func getAttributedString(text: String) -> NSAttributedString {
        let builder = AttributedStringBuilder()
        builder.text(text)
        builder.defaultAttributes = [
            .alignment(.center),
            .textColor(UIColor.black),
            .font(Brandbook.Font.body1),
        ]
        builder.newlines(2, attributes: builder.defaultAttributes)
        return builder.attributedString
    }
    
}

// MARK: - ChipsViewCollectionCell Conformance
extension IconedChipsCollectionViewCell: ChipsViewCollectionCell {
    func configure(viewModel: ChipsCellViewModel) {
        guard let model = viewModel as? IconedChipsCellViewModel else {
            return
            
        }
        contentView.backgroundColor = model.state.backgroundColor
        self.state = model.state
        if let url = URL(string: model.iconString ?? "") {
            icon.sd_setImage(with: url, completed: nil)
        } else {
            icon.image = UIImage(systemName: "doc.text.image")
        }
        textLabel.textColor = model.state.textColor
        bottomLabel.textColor = model.state.textColor
        contentView.layer.borderColor = model.state.borderColor.cgColor
        switch model.titleType {
        case .singleLine(let text):
            textLabel.text = text
            textLabel.font = Brandbook.Font.smallButton
            bottomLabel.text = nil
        case .twoLine(let tuple):
            textLabel.text = tuple.topText
            textLabel.font = Brandbook.Font.caption1
            bottomLabel.font = Brandbook.Font.caption1
            bottomLabel.text = tuple.bottomText
        }
        layoutIfNeeded()
    }
    
}
