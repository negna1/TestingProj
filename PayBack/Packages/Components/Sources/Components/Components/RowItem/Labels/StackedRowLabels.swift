
import UIKit

public class StackedRowLabels: UIStackView {
    
    private typealias Font = RowLabelsConstants.Font
    private lazy var initialLabelsSet: [LocalLabel] = {
        [
            labelTitle,
            labelBody,
            labelDescription
        ]
    }()
    
    private lazy var labelTitle: LocalLabel = {
        let label = LocalLabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.styles.forTitle
        label.setContentCompressionResistancePriority(
            .defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var labelBody: LocalLabel = {
        let label = LocalLabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.styles.forBody
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(
            .defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var labelDescription: LocalLabel = {
        let label = LocalLabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Font.styles.forDescription
        label.setContentCompressionResistancePriority(
            .defaultLow, for: .horizontal)
        return label
    }()
}

public extension StackedRowLabels {
    
    convenience init() {
        self.init(frame: .zero)
        setUp()
    }
    
    convenience init(model: StackedRowLabels.ViewModel) {
        self.init(frame: .zero)
        setUp()
        configure(with: model)
    }
    
    func configure(with model: StackedRowLabels.ViewModel) {
        configureVisibility(for: model.type)
        updateLabelColors(with: model)
        updateLabels(for: model.type)
    }
    
    private func setUp() {
        axis = .vertical
        spacing = Spacing.XS2.floatValue
        initialLabelsSet.forEach { label in
            addArrangedSubview(label)
        }
    }
    
    private func updateLabelColors(with model: StackedRowLabels.ViewModel) {
        labelTitle.textColor = model.colors.title
        labelBody.textColor = model.colors.body
        labelDescription.textColor = model.colors.descr
    }
}

extension StackedRowLabels {
    private func updateLabels(for type: StackedRowLabels.`Type`) {
        switch type {
        case .oneLine(let body):
            labelBody.setUp(with: body)
        case .twoLine(let title, let body):
            labelTitle.setUp(with: title)
            labelBody.setUp(with: body)
        case .twoLineReverse(let title, let body):
            labelBody.setUp(with: body)
            labelDescription.setUp(with: title)
        case .threeLine(let title, let body, let descr):
            labelTitle.setUp(with: title)
            labelBody.setUp(with: body)
            labelDescription.setUp(with: descr)
        }
    }
    
    private func configureVisibility(for type: StackedRowLabels.`Type`) {
        labelTitle.isHidden = type.visibility.isTitleHidden
        labelBody.isHidden = type.visibility.isBodyHidden
        labelDescription.isHidden = type.visibility.isDescriptionHidden
    }
}
