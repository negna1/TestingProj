
import UIKit

class FlexibleElementWrapper: UIView {
    
    init(subview: UIView) {
        super.init(frame: .zero)
        self.setUp(subview: subview)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUp(subview: UIView) {
        addSubview(subview)
        subview.right(toView: self)
        subview.left(toView: self)
        subview.centerVertically(to: self)
        subview.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 0).isActive = true
        subview.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: 0).isActive = true
    }
}


