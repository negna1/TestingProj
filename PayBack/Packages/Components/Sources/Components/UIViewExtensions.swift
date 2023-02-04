

import UIKit

public extension UIView {
    static func configure<T>(_ value: T, using closure: (inout T) throws -> () ) rethrows -> T {
        var value = value
        try closure(&value)
        return value
    }
    
    func layoutSidesTo<T: UIView>(superview: T, spacing: CGFloat = 0.0) {
        self.layout(using: [
            superview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -spacing),
            superview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: spacing)
        ])
    }
    
    func layoutHeightTo<T: UIView>(superview: T, spacing: CGFloat = 0.0) {
        self.layout(using: [
            superview.topAnchor.constraint(equalTo: self.topAnchor, constant: -spacing),
            superview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spacing)
        ])
    }
    
    func stretchLayout(with padding: CGFloat = 0) {
        if let superview = superview {
            layout(using: [
                leftAnchor.constraint(equalTo: superview.safeLeftAnchor, constant: padding),
                rightAnchor.constraint(equalTo: superview.safeRightAnchor, constant: -padding),
                topAnchor.constraint(equalTo: superview.safeTopAnchor, constant: padding),
                bottomAnchor.constraint(equalTo: superview.safeBottomAnchor, constant: -padding)
            ])
        }
    }
    
    func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }

    var heightLayoutConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }

    var widthLayoutConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var trailingLayoutConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .right && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
    
    var leadingLayoutConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .left && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
    
    var bottomLayoutConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .bottom && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
    
    var topLayoutConstraint: NSLayoutConstraint? {
        get {
            return constraints.first {
                $0.firstAttribute == .top && $0.relation == .equal
            }
        }
        set {
            setNeedsLayout()
        }
    }
    
    func shake(duration: CFTimeInterval) {
        
        let shakeValues = [-5, 5, -5, 5, -3, 3, -2, 2, 0]
        
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translation.values = shakeValues
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = shakeValues.map { (Int(Double.pi) * $0) / 180 }
        
        let shakeGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = 0.250
        layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func fillParentView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}

public extension UIView {
    
    var isHiddenInStackView: Bool {
        get { return isHidden }
        set {
            if isHidden != newValue {
                isHidden = newValue
            }
        }
    }
}

public extension UIView {

    var id: String? {
        get {
            return self.accessibilityIdentifier
        }
        set {
            self.accessibilityIdentifier = newValue
        }
    }

    func view(withId id: String) -> UIView? {
        if self.id == id {
            return self
        }
        for view in self.subviews {
            if let view = view.view(withId: id) {
                return view
            }
        }
        return nil
    }
}

extension UIResponder {
    private weak static var _currentFirstResponder: UIResponder? = nil
    
    public static var current: UIResponder? {
        UIResponder._currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(sender:)), to: nil, from: nil, for: nil)
        return UIResponder._currentFirstResponder
    }
    
    @objc internal func findFirstResponder(sender: AnyObject) {
        UIResponder._currentFirstResponder = self
    }
    
}


extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { (view) in
            addSubview(view)
        }
    }
}
