

import Foundation
import UIKit

class BorderView : UIView {
    
    private let color: UIColor
    private let borderWidth: CGFloat
    private let size: CGSize
    private let cornerRadius: CGFloat
    private let shapeLayer = CAShapeLayer()
    private var borderLayer: CAShapeLayer?
    
    override func layoutSubviews() {
        let path = calculateLayerPath()
        setupShapeLayer(with: path)
        setupBorderLayer(with: path)
    }
    
    private func setupBorderLayer(with path: CGPath) {
        borderLayer?.removeFromSuperlayer()
        borderLayer = CAShapeLayer()
        guard let borderLayer = borderLayer else { return }
        borderLayer.path = path
        borderLayer.lineWidth = borderWidth
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        layer.addSublayer(borderLayer)
    }
    
    private func setupShapeLayer(with path: CGPath) {
        shapeLayer.path = path
        layer.mask = shapeLayer
    }
    
    private func calculateLayerPath() -> CGPath {
        return UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
    public init(size: CGSize, width: CGFloat, cornerRadius: CGFloat, color: UIColor) {
        self.size = size
        self.borderWidth = width
        self.cornerRadius = cornerRadius
        self.color = color
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
