

import UIKit

public class StatusBadge: UIView {

    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var type: StatusBadgeType? {
        didSet {
            configure()
        }
    }
    
    public init(type: StatusBadgeType) {
        super.init(frame: .zero)
        self.type = type
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(by: .Circle)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupVisual()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentContainerView)
    }
    
    private func setupConstraints() {
        width(equalTo: StatusBadgeConsts.size)
        height(equalTo: StatusBadgeConsts.size)
        
        contentContainerView.top(toView: self, constant: Spacing.S.floatValue)
        contentContainerView.bottom(toView: self, constant: Spacing.S.floatValue)
        contentContainerView.left(toView: self, constant: Spacing.S.floatValue)
        contentContainerView.right(toView: self, constant: Spacing.S.floatValue)
    }
    
    private func setupVisual() {
        backgroundColor = StatusBadgeConsts.backgroundColor
    }
    
    private func configure() {
        guard let contentView = type?.content else { return }
        
        contentContainerView.removeAllSubviews()
        contentContainerView.addSubview(contentView)
        contentView.fillParentView()
    }

}
