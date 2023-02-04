

// FIXME: UIKit consists of Foundation, so no need to import it
import Foundation
import UIKit

//@available(*, deprecated, message: "Will be deleted on ?")

public class PrimaryButtonComponent: LocalButton {

    public var buttonState: ButtonState = .Active {
        didSet {
            isUserInteractionEnabled = buttonState == .Active
            setupColors()
        }
    }
    public var isLoading:Bool = false { didSet { updateLoader() }}
    private var viewModel: PrimaryButtonComponentViewModelProtocol = PrimaryButtonComponentFactory.getViewModel()
    
    private let loadingImageOffset = Spacing.M.floatValue
    private lazy var loadingIndicator = LoadingIndicator()
    
    public var type: ButtonType
    public enum ButtonType {
        case standard, small
    }

    public var title: String {
        get { title(for: .normal) ?? "" }
        set { setTitle(newValue, for: .normal) }
    }

    public init(title: String, type: ButtonType = .standard) {
        self.type = type
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        self.type = .standard
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        configureButton()
        configureTitleLabel()
    }

    /* FIXME: little SRP Violation :)
     * Now this function always has to be called before 'configureTitleLabel'
     * so set 'translatesAutoresizingMaskIntoConstraints' value beforehand.
     * 'configureButton' and 'configureTitleLabel' methods won't be coupled anymore
     */
    private func configureButton() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: viewModel.layout.height(type: type)).isActive = true
    }

    /* FIXME: This method doesn't need to know about view model
     * just pass layout as a parameter
     * Current: func configureTitleLabel()
     * Better: func configureTitleLabel(with layout: PrimaryButtonComponentLayoutProtocol)
     */
    private func configureTitleLabel() {
        titleLabel?.font = viewModel.layout.font(for: type)
        titleLabel?.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: viewModel.layout.padding).isActive = true
        titleLabel?.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -viewModel.layout.padding).isActive = true
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
        titleLabel?.textColor = viewModel.titleColor(forState: buttonState)
        layer.borderColor = viewModel.borderColor(forState: buttonState)?.cgColor
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

extension PrimaryButtonComponent: PrimaryButtonProtocol {

    public func setContentTitle(title: String) {
        setTitle(title, for: .normal)
    }
}

extension PrimaryButtonComponent: LoadingIndictable {
    
    private var imageName: String {
        switch type {
        case .standard:
            return "badgeLoadingWhiteMedium"
        case .small:
            return "badgeLoadingWhiteSmall"
        }
    }
    
    public var indicationImage: UIImage {
        return UIImage()
        
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
