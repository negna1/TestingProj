
import UIKit

public class ElementWrapper<T: UIView>: UIClosureControl {
    
    public var instance: T
    
    init(subview: T) {
        self.instance = subview
        super.init()
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        instance.translatesAutoresizingMaskIntoConstraints = false
        addSubview(instance)
        setUpConstraints()
    }
    
    internal func setUpConstraints() {
        instance.centerHorizontally(to: self)
        instance.centerVertically(to: self)
        instance.left(toView: self)
        instance.right(toView: self)
    }
}
