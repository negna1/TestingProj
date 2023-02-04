
import UIKit

public protocol ChipsViewCollectionCell: UICollectionViewCell {
    func configure(viewModel: ChipsCellViewModel)
}

class StandartChipsCollectionCell: UICollectionViewCell {
    
    override var reuseIdentifier: String? { "StandartTabCollectionCell" }
    
    let titleLabel: LocalLabel = {
        let label = LocalLabel()
        label.font = Brandbook.Font.smallButton
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet(oldValue) {
            guard state == .enabled else { return }
            if oldValue {
                backgroundColor = UIColor.green
                titleLabel.textColor = UIColor.green
            } else {
                backgroundColor = UIColor.green
                titleLabel.textColor = UIColor.green
            }
        }
    }

//    FIXME: Switch cases may be avoided by making Struct and associate it with Enum
    var state: StandardChipsCellState = .disabled 
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureTitleLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .Circle)
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.left(toView: contentView, constant: CGFloat(Spacing.M.rawValue))
        titleLabel.right(toView: contentView, constant: CGFloat(Spacing.M.rawValue))
        titleLabel.top(toView: contentView)
        titleLabel.bottom(toView: contentView)
    }
}

// MARK: - TabCollectionCell
extension StandartChipsCollectionCell: ChipsViewCollectionCell {
    func configure(viewModel: ChipsCellViewModel) {
        guard let model = viewModel as? StandardChipsCellViewModel else { return }
        titleLabel.text = model.title
        backgroundColor = model.state.backgroundColor
        titleLabel.textColor = model.state.titleColor
//        state = model.state
    }
}
