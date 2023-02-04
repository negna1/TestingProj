

import Foundation
import UIKit

extension UIView {
    // MARK: Elevation
    
    ///makes UIView elevate by applying shadow
    public func elevate(level: ElavationLevel) {
        switch level {
        case .Ten:
            self.layer.applyShadow(x: 0, y: 2, blur: 4, spread: 1, alpha: 0.08)
        case .Twenty:
            self.layer.applyShadow(x: 0, y: 4, blur: 8, spread: 1, alpha: 0.02)
        case .Thirty:
            self.layer.applyShadow(x: 0, y: 8, blur: 16, spread: 1, alpha: 0.04)
        }
    }
    
    ///makes UIView elevate by applying shadow and corner radius.
    ///
    /// - Parameters:
    ///     - corners: array of corners on which cornerRadius will apply
    public func elevate(level: ElavationLevel, cornerRadius: CornerRadius, corners: UIRectCorner = [.allCorners]) {
        let radius = cornerRadius == .Circle ? self.bounds.size.height / 2.0 : CGFloat(cornerRadius.rawValue)
        switch level {
        case .Ten:
            self.layer.applyShadow(x: 0, y: 2, blur: 4, spread: 1, alpha: 0.08, cornerRadius: radius, corners: corners)
        case .Twenty:
            self.layer.applyShadow(x: 0, y: 4, blur: 8, spread: 1, alpha: 0.02, cornerRadius: radius, corners: corners)
        case .Thirty:
            self.layer.applyShadow(x: 0, y: 8, blur: 16, spread: 1, alpha: 0.04, cornerRadius: radius, corners: corners)
        }
    }
}

extension CALayer {
    func applyShadow(
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0,
        alpha: Float = 0.5,
        cornerRadius: CGFloat = 0,
        corners: UIRectCorner = .allCorners
    )
    {
        let color = UIColor.black
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        if cornerRadius > 0 {
            self.cornerRadius = CGFloat(cornerRadius)
            maskedCorners = UIRectToCACorner(corners: corners)
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
            shadowPath = path
        } else {
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
        // Uncoment for components with complex animations to improve performance
        //        shouldRasterize = true
        //        rasterizationScale = UIScreen.main.scale
    }
    
    // Helper Index based Mapping table UIRectCorner To CACornerMask.
    // [.topLeft, .topRight, .bottomLeft, .bottomRight]
    private func UIRectToCACorner(corners: UIRectCorner) -> CACornerMask {
        var answer:CACornerMask = []
        let caRect: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        guard corners != .allCorners else {
            return caRect
        }
        
        if corners.contains(.topLeft) {
            answer.insert(.layerMinXMinYCorner)
        }
        
        if corners.contains(.topRight) {
            answer.insert(.layerMaxXMinYCorner)
        }
        
        if corners.contains(.bottomLeft) {
            answer.insert(.layerMinXMaxYCorner)
        }
        
        if corners.contains(.bottomRight) {
            answer.insert(.layerMaxXMaxYCorner)
        }
        
        return answer
    }
}
