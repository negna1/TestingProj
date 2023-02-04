
import UIKit

public struct InfoBadgeViewModel {
    var type: InfoBadgeType
    var text: String
    
    public init(type: InfoBadgeType, text: String) {
        self.type = type
        self.text = text
    }
}

public class InfoBadgeView: UIView {
    
    fileprivate let negativeTextColor =  UIColor.orange
    fileprivate let normalTextColor =  UIColor.orange
    fileprivate let negativeBackgroundColor =  UIColor.orange
    
    private var label: LocalLabel = {
        let lbl = LocalLabel()
        lbl.font = Brandbook.Font.body1
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init(with viewModel: InfoBadgeViewModel) {
        super.init(frame: .zero)
        configure(with: viewModel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .Fifty)
    }
    
    public func configure(with viewModel: InfoBadgeViewModel) {
        setupConstraints()
        label.text = viewModel.text
        label.textColor = viewModel.type == .negative ? negativeTextColor : normalTextColor
        backgroundColor = viewModel.type == .negative ? negativeBackgroundColor : .clear
        layer.borderWidth = viewModel.type == .negative ? 0 : 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setupConstraints() {
        addSubview(label)
        label.top(toView: self, constant: 1)
        label.left(toView: self, constant: 8)
        label.right(toView: self, constant: 8)
        label.bottom(toView: self, constant: 1)
    }

}
