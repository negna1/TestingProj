

import UIKit

public class TextSmallBadge: LocalLabel {
    
    public init() {
        super.init(frame: .zero)
        self.style()
    }
    
    public convenience init(with model: TextSmallBadge.ViewModel) {
        self.init()
        self.configure(with: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + Spacing.M.floatValue, height: size.height + Spacing.XS3.floatValue)
    }
    
    public func configure(with model: TextSmallBadge.ViewModel) {
        self.text = model.text.title
        self.textColor = model.text.color
        self.backgroundColor = model.badgeColor
    }
    
    private func style() {
        self.clipsToBounds = true
        self.textAlignment = .center
        self.roundCorners(by: .Twenty)
        self.font = Brandbook.Font.caption1
    }
}
