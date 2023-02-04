

import Foundation
import UIKit

public class SecondaryButtonComponent: LocalButton {
    
    private var title: String! {
        didSet { setupView() }
    }
    
    private var icon: UIImage? {
        didSet { setupView() }
    }
    
    public var isLoading:Bool = false { didSet { updateLoader() }}
    
    private let loadingImageOffset = Spacing.S.floatValue
    private lazy var loadingIndicator = LoadingIndicator()
    
    private var dashed: Bool = false
    private var borderLayer: CAShapeLayer?
    private let shapeLayer = CAShapeLayer()
    private var iconImageView = UIImageView()
    private var textLabel = LocalLabel()
    public var buttonState: ButtonState = .Active {
        didSet { setupColors() }
    }
    
    private var viewmodel: SecondaryButtonComponentViewModelProtocol = SecondaryButtonComponentFactory.getButton(image: nil, dashed: false)
    public init(title: String, image: UIImage?, dashed: Bool) {
        self.title = title
        self.icon = image
        self.dashed = dashed
        viewmodel = SecondaryButtonComponentFactory.getButton(image: image, dashed: dashed)
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func layoutSubviews() {
        let path = calculateLayerPath()
        setupShapeLayer(with: path)
        if self.dashed {
            setupBorderLayer(with: path)
        }
        setupColors()
    }
    
    private func setupView() {
        
        if title == nil {
            title = currentTitle
        }
        
        // MARK: Main View Button
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Container Content View
        let contentContainerView  = UIView()
        
        addSubview(contentContainerView)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentContainerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant:viewmodel.layout.contentPadding).isActive = true
        contentContainerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -viewmodel.layout.contentPadding).isActive = true
        contentContainerView.isUserInteractionEnabled = false
        
        // MARK: Title label
        contentContainerView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = title
        textLabel.textAlignment = .center
        textLabel.font = viewmodel.layout.font
        
        // MARK: Setup Icon + Title
        if (self.icon != nil) {
            let icon = iconImageView
            contentContainerView.addSubview(icon)
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.image = self.icon?.withRenderingMode(.alwaysTemplate)
            icon.widthAnchor.constraint(equalToConstant: viewmodel.layout.iconSize).isActive = true
            icon.heightAnchor.constraint(equalToConstant: viewmodel.layout.iconSize).isActive = true
            icon.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor).isActive = true
            icon.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
            
            textLabel.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: viewmodel.layout.iconPadding).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        } else {
            // MARK: Setup Title Only
            textLabel.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        }
    }
    
    private func setupColors() {
        backgroundColor = viewmodel.backgroundColor(forState: buttonState)
        textLabel.textColor = viewmodel.titleColor(forState: buttonState)
        iconImageView.tintColor = viewmodel.iconColor(forState: buttonState)
        borderLayer?.strokeColor = viewmodel.borderColor(forState: buttonState)?.cgColor
    }
    
    private func calculateLayerPath() -> CGPath {
        return UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: bounds.height*viewmodel.layout.cornerRadius, height: bounds.height*viewmodel.layout.cornerRadius)).cgPath
    }
    
    private func setupBorderLayer(with path: CGPath) {
        borderLayer?.removeFromSuperlayer()
        borderLayer = CAShapeLayer()
        guard let borderLayer = borderLayer else { return }
        borderLayer.path = path
        borderLayer.lineDashPattern = viewmodel.layout.dashPattern
        borderLayer.lineWidth = viewmodel.layout.borderWidth
        borderLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(borderLayer)
    }
    
    private func setupShapeLayer(with path: CGPath) {
        shapeLayer.path = path
        layer.mask = shapeLayer
    }
    
    private func updateLoader() {
        if isLoading {
            loadingIndicator.addIndication(forIndicatable: self, alignment: .right, offset: loadingImageOffset)
        } else {
            loadingIndicator.removeIndication()
        }
    }
    
    // MARK: Touch Events
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if buttonState != .Disabled { buttonState = .Pressed }
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if buttonState != .Disabled { buttonState = .Active }
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if buttonState != .Disabled { buttonState = .Active }
    }

    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
}

// MARK: Button Protocol Methods

extension SecondaryButtonComponent: SecondaryButtonProtocol {
    public func setContentTitle(title: String) {
        self.title = title
    }
}

extension SecondaryButtonComponent: LoadingIndictable {

    public var indicationImage: UIImage {
        return UIImage(systemName: "button.programmable")?.withTintColor(.orange) ?? UIImage()
        
    }
    public var contentView: UIView { return self }
    
    
    
    public func enableInteraction() {
        self.isEnabled = true
        buttonState = .Active
    }
    
    public func disableInteraction() {
        
        self.isEnabled = false
        buttonState = .Disabled
    }
}
