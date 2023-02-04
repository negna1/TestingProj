

import UIKit

class CheckBoxChipsCollectionCell: UICollectionViewCell {
    
    override var reuseIdentifier: String? { "CheckBoxTabCollectionCell" }
    
    private let checkBox: CheckBox = {
        let checkbox = CheckBox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        return checkbox
    }()
    
    override var isHighlighted: Bool {
        didSet(oldValue) {
            guard cellState == .enabled else { return }
            if oldValue {
                backgroundColor = .gray
            } else {
                backgroundColor = .gray
            }
            // checkBox.animateBorderAndTextColor(isHighlighted: !oldValue)
        }
    }

//    FIXME: Switch cases may be avoided by making Struct and associate it with Enum
    var cellState: CheckboxChipsCellState = .disabled {
        didSet {
            switch cellState {
            case .active:
                backgroundColor = .green
            case .enabled:
                backgroundColor = .clear
            case .disabled:
                backgroundColor = .gray
            case .intermediate:
                backgroundColor = .orange
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCheckbox()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCheckbox()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .Circle)
    }
    
    private func configureCheckbox() {
        contentView.addSubview(checkBox)
        checkBox.left(toView: contentView, constant: Spacing.XS.floatValue)
        checkBox.right(toView: contentView, constant: Spacing.M.floatValue)
        checkBox.centerVertically(to: contentView)
        checkBox.isUserInteractionEnabled = false
    }
}

// MARK: - TabCollectionCell
extension CheckBoxChipsCollectionCell: ChipsViewCollectionCell {
    func configure(viewModel: ChipsCellViewModel) {
        guard let model = viewModel as? CheckboxChipsCellViewModel else { return }
        cellState = model.state
        checkBox.configure(type: .checkBoxWithTitle(title: viewModel.title, state: cellState.checkboxState))
    }
}
