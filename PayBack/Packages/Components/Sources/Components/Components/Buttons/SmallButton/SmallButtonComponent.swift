
import Foundation
import UIKit

public class SmallButtonComponent: LocalButton {
    
    private var title: String! {
        didSet { setupView() }
    }
    
    private var icon: UIImage? {
        didSet { setupView() }
    }
    
    private var borderLayer: CAShapeLayer?
    private let shapeLayer = CAShapeLayer()
    private var iconImageView = UIImageView()
    private var textLabel = LocalLabel()
    public var buttonState: ButtonState = .Active {
        didSet { setupColors() }
    }
    
    private var bordered: Bool = false
    
    private var viewModel: SmallButtonComponentViewModelProtocol!
    
    public init(title: String, bordered: Bool) {
        self.title = title
        self.bordered = bordered
        viewModel = SmallButtonComponentFactory.getButton(icon: nil, bordered: bordered)
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    public init(title: String, icon: UIImage?) {
        self.title = title
        self.icon = icon
        viewModel = SmallButtonComponentFactory.getButton(icon: icon, bordered: false)
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
        if self.bordered {
            setupBorderLayer(with: path)
        }
        setupColors()
    }
    
    private func setupView() {
        // MARK: Main View Button
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: viewModel.layout.height).isActive = true
        
        // MARK: Container Content View
        let contentContainerView = UIView()
        contentContainerView.isUserInteractionEnabled = false
        addSubview(contentContainerView)
        contentContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentContainerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant:viewModel!.layout.contentPadding).isActive = true
        contentContainerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -viewModel!.layout.contentPadding).isActive = true
        
        
        contentContainerView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = title
        textLabel.textAlignment = .center
        textLabel.font = viewModel.layout.font
        // MARK: Setup Icon + Title
        if (self.icon != nil) {
            let icon = iconImageView
            contentContainerView.addSubview(icon)
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.image = self.icon?.withRenderingMode(.alwaysTemplate)
            
            icon.widthAnchor.constraint(equalToConstant: viewModel.layout.iconSize).isActive = true
            icon.heightAnchor.constraint(equalToConstant: viewModel.layout.iconSize).isActive = true
            icon.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor).isActive = true
            icon.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
            textLabel.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -viewModel.layout.iconPadding!).isActive = true
        } else {
            // MARK: Setup Title Only
            textLabel.centerYAnchor.constraint(equalTo: contentContainerView.centerYAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor).isActive = true
        }
    }
    
    private func setupColors() {
        backgroundColor = viewModel.backgroundColor(forState: buttonState)
        textLabel.textColor = viewModel.titleColor(forState: buttonState)
        iconImageView.tintColor = viewModel.iconColor(forState: buttonState)
        borderLayer?.strokeColor = viewModel.borderColor(forState: buttonState)?.cgColor
    }
    
    private func calculateLayerPath() -> CGPath {
        return UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: bounds.height*(viewModel!.layout.cornerRadius), height: bounds.height*(viewModel!.layout.cornerRadius))).cgPath
    }
    
    private func setupBorderLayer(with path: CGPath) {
        borderLayer = CAShapeLayer()
        guard let borderLayer = borderLayer else { return }
        borderLayer.path = path
        borderLayer.lineWidth = viewModel!.layout.borderWidth
        borderLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(borderLayer)
    }
    
    private func setupShapeLayer(with path: CGPath) {
        shapeLayer.path = path
        layer.mask = shapeLayer
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

extension SmallButtonComponent: SmallButtonProtocol {
    public func setContentTitle(title: String) {
        self.title = title
    }
}
