
import UIKit

public class Helper {
    ///Deprecated, will be removed  soon.
    ///Please migrate to another API
    @available(*, deprecated, message: "This will be removed in v2.0. please refactor acordingly")
    static func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}

public extension UIView {
    
    // MARK: Safe UIView anchors
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    
    // MARK: Constraint helper methods
    func left(toView view: UIView, constant value: CGFloat = 0) {
        self.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: value).isActive = true
    }
    func leftNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: value).isActive = true
    }
    func relativeLeft(toView view: UIView, constant value: CGFloat) {
        self.leftAnchor.constraint(equalTo: view.safeRightAnchor, constant: value).isActive = true
    }
    func right(toView view: UIView, constant value: CGFloat = 0) {
        self.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -value).isActive = true
    }
    func right(toView view: UIView, greaterThanOrEqualToConstant value: CGFloat) {
        self.rightAnchor.constraint(greaterThanOrEqualTo: view.safeRightAnchor, constant: -value).isActive = true
    }
    func left(toView view: UIView, greaterThanOrEqualToConstant value: CGFloat) {
        self.leftAnchor.constraint(greaterThanOrEqualTo: view.safeLeftAnchor, constant: value).isActive = true
    }
    func rightNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -value).isActive = true
    }
    
    func relativeRight(toView view: UIView, constant value: CGFloat) {
        self.rightAnchor.constraint(equalTo: view.safeLeftAnchor, constant: value).isActive = true
    }
    func top(toView view: UIView, constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: value).isActive = true
    }
    @discardableResult
    func bottom(toView view: UIView, constant value: CGFloat = 0) -> NSLayoutConstraint {
        let cconstant = self.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -value)
        cconstant.isActive = true
        return cconstant
    }
    func topNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: value).isActive = true
    }
    func bottomNotSafe(toView view: UIView, constant value: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -value).isActive = true
    }
    func relativeBottom(toView view: UIView, constant value: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: view.safeTopAnchor, constant: -value).isActive = true
    }
    func relativeTop(toView view: UIView, constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.safeBottomAnchor, constant: value).isActive = true
    }
    func width(equalTo dimension: NSLayoutDimension) {
        self.widthAnchor.constraint(equalTo: dimension).isActive = true
    }
    func width(equalTo dimension: NSLayoutDimension, constant value: CGFloat) {
        self.widthAnchor.constraint(equalTo: dimension, constant: value).isActive = true
    }
    func height(to dimension: NSLayoutDimension, multiplier: CGFloat = 0) {
        self.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
    }
    func height(equalTo constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    func height(greaterThanOrEqualToConstant constant: CGFloat) {
        self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    func width(equalTo constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    func width(lessThanOrEqualTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) {
        self.widthAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier).isActive = true
    }
    func width(lessThanOrEqualTo constant: CGFloat) {
        self.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    func centerVertically(to view: UIView) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func centerHorizontally(to view: UIView) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension UIWindow {
    public var topSafeAreaInset: CGFloat {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets.top
        }
        return 0
    }
}
