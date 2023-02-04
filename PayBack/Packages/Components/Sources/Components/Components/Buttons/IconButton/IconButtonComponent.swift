
import Foundation
import UIKit

public class IconButtonComponent: UIButton {

    public enum ButtonType: Int {
        case Small
        case Normal
    }

    public var buttonState: ButtonState = .Active { didSet { setupColors() } }
    private var viewModel: IconButtonComponentViewModelProtocol!
    
    public init(buttonType: ButtonType, icon: UIImage, iconTint: UIColor? = nil) {
        self.viewModel = IconButtonComponentFactory.getViewModel(type: buttonType)
        super.init(frame: .zero)
        commonInit(icon, iconTint: iconTint)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable var type: Int = -1

    public override func awakeFromNib() {
        super.awakeFromNib()
        if let buttonType = ButtonType(rawValue: type) {
            self.viewModel = IconButtonComponentFactory.getViewModel(type: buttonType)
            commonInit(imageView!.image!, iconTint: nil)
        } else {
            fatalError("Setup User Defined Runtime Attribute 'Type'")
        }
    }

    private func commonInit(_ icon: UIImage, iconTint: UIColor?) {
        configureButton()
        configureIcon(icon, iconTint: iconTint)
    }

    private func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: viewModel.layout.height).isActive = true
        widthAnchor.constraint(equalToConstant: viewModel.layout.width).isActive = true
    }

    private func configureIcon(_ icon: UIImage, iconTint: UIColor?) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        adjustsImageWhenHighlighted = false
        setImage(icon.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = iconTint ?? viewModel.iconColor(forState: buttonState)
        let iconPadding = viewModel.layout.iconPadding
        imageEdgeInsets = UIEdgeInsets(top: iconPadding, left: iconPadding, bottom: iconPadding, right: iconPadding)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
        setupColors()
    }

    private func setupLayer() {
        layer.borderWidth = viewModel.layout.borderWidth
        layer.cornerRadius = viewModel.layout.cornerRadius
    }
    
    private func setupColors() {
        backgroundColor = viewModel.backgroundColor(forState: buttonState)
        layer.borderColor = viewModel.borderColor(forState: buttonState)?.cgColor
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

extension IconButtonComponent: IconButtonProtocol {
    
    public func setIcon(_ icon: UIImage, iconTint: UIColor? = nil) {
        setImage(icon, for: .normal)
        if let iconTint = iconTint {
            tintColor = iconTint
        }
    }
    
}
