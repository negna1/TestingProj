
import UIKit

// MARK:- Text Icon Badge Button Component
public final class TextIconBadgeButtonComponent: LocalButton {
    
    // MARK: Static constants
    public static let defaultBadgeNumber: UInt = 100
    
    // MARK: Properties
    public var badge: UInt
    {
        didSet {
            if hasBadge { badgeComponent.configure(with: .init(.info, badge)) }
            reflectStateChange()
        }
    }
    
    public var icon: UIImage?
    {
        didSet {
            iconImageView.image = icon
            reflectStateChange()
        }
    }
    
    public var title: String?
    {
        didSet {
            label.text = title
            reflectStateChange()
        }
    }
    
    public var buttonState: ButtonState = .Active
        { didSet { reflectStateChange() } }
    
    private let background: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = VM.Layout.cornerRadius
        return view
    }()
    
    private lazy var badgeComponent: Badge = {
        let badgeComponent: Badge = .init(with: .init(.info, badge))
        badgeComponent.translatesAutoresizingMaskIntoConstraints = false
        badgeComponent.isUserInteractionEnabled = false
        return badgeComponent
    }()
    
    private lazy var label: LocalLabel = {
        let label: LocalLabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = false
        label.font = VM.Font.title
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.text = title
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = icon
        return imageView
    }()
    
    private typealias VM = TextIconBadgeButtonComponentViewModel
    
    private var hasBadge: Bool { badge > 0 }
    
    private var badgeLeadingConstraintToLeading: NSLayoutConstraint? = nil
    private var labelLeadingConstraintToBadge: NSLayoutConstraint? = nil
    private var labelLeadingConstraintToLeading: NSLayoutConstraint? = nil
    
    // MARK: Initializers
    public init(title: String, icon: UIImage?, badge: UInt = TextIconBadgeButtonComponent.defaultBadgeNumber) {
        self.badge = badge
        self.title = title
        self.icon = icon
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Setup
private extension TextIconBadgeButtonComponent {
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setUpLayout()
        reflectStateChange()
    }
    
    func addSubviews() {
        addSubview(background)
        background.addSubview(badgeComponent)
        background.addSubview(label)
        background.addSubview(iconImageView)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: VM.Layout.height),

            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // BADGE: Leading, Trailing, and Center are set in reflectStateChange()
            
            // LABEL: Leading and Trailing are set in reflectStateChange()
            label.heightAnchor.constraint(equalToConstant: VM.Layout.labelHeight),
            label.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: VM.Layout.iconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: VM.Layout.iconSize.height),
            iconImageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: VM.Layout.iconMarginHor),
            iconImageView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -VM.Layout.iconMarginHor),
            iconImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
        ])
    }
}

// MARK:- State Change
private extension TextIconBadgeButtonComponent {
    func reflectStateChange() {
        setColors()
        setUpStateLayout()
    }
    
    func setColors() {
        background.backgroundColor = VM.Color.background(state: buttonState, hasBadge: hasBadge)
        label.textColor = VM.Color.foreground(for: buttonState)
        iconImageView.tintColor = VM.Color.foreground(for: buttonState)
    }
    
    func setUpStateLayout() {
        // Makes sure that badge state has changed, otherwise constraint will be activated twice
        let badgeStateHasChanged: Bool = {
            let isInit: Bool =
                badgeLeadingConstraintToLeading == nil &&
                labelLeadingConstraintToBadge == nil &&
                labelLeadingConstraintToLeading == nil
            guard !isInit else { return true }
            
            let badgeComponentIsAddedToSubview: Bool = labelLeadingConstraintToLeading == nil
            switch (hasBadge, badgeComponentIsAddedToSubview) {
            case (false, false): return false
            case (false, true): return true
            case (true, false): return true
            case (true, true): return false
            }
        }()
        guard badgeStateHasChanged else { return }
        
        switch hasBadge {
        case false:
            badgeComponent.removeFromSuperview()
            
            badgeLeadingConstraintToLeading?.isActive = false
            badgeLeadingConstraintToLeading = nil
            
            labelLeadingConstraintToBadge?.isActive = false
            labelLeadingConstraintToBadge = nil
            
            labelLeadingConstraintToLeading = label.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: VM.Layout.labelMarginLeadingNoBadge)
            labelLeadingConstraintToLeading?.isActive = true
            
        case true:
            background.addSubview(badgeComponent)
            
            badgeComponent.centerYAnchor.constraint(equalTo: background.centerYAnchor).isActive = true
            
            labelLeadingConstraintToLeading?.isActive = false
            labelLeadingConstraintToLeading = nil
            
            badgeLeadingConstraintToLeading = badgeComponent.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: VM.Layout.badgeMarginLeading)
            badgeLeadingConstraintToLeading?.isActive = true
            
            labelLeadingConstraintToBadge = label.leadingAnchor.constraint(equalTo: badgeComponent.trailingAnchor, constant: VM.Layout.labelMarginLeading)
            labelLeadingConstraintToBadge?.isActive = true
        }
    }
}

// MARK:- Touches
extension TextIconBadgeButtonComponent {
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard buttonState != .Disabled else { return }
        buttonState = .Pressed
    }

    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard buttonState != .Disabled else { return }
        buttonState = .Active
    }

    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)

        guard buttonState != .Disabled else { return }
        buttonState = .Active
    }
}

// MARK:- Test
//public final class TextIconBadgeButtonTestVC: UIViewController {
//    private let component: TextIconBadgeButtonComponent = {
//        let component: TextIconBadgeButtonComponent = .init(
//            title: "ფილტრი",
//            icon: Brandbook.Image.icons24.systemSetting.image.withRenderingMode(.alwaysTemplate),
//            badge: 3
//        )
//
//        component.translatesAutoresizingMaskIntoConstraints = false
//
//        return component
//    }()
//
//    private lazy var incrementButton: UIButton = {
//        let button: UIButton = .init()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle(" + ", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(increment), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var decrementButton: UIButton = {
//        let button: UIButton = .init()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle(" - ", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(decrement), for: .touchUpInside)
//        return button
//    }()
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        view.addSubview(component)
//        view.addSubview(incrementButton)
//        view.addSubview(decrementButton)
//
//        NSLayoutConstraint.activate([
//            component.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            component.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//
//            incrementButton.topAnchor.constraint(equalTo: component.bottomAnchor, constant: 200),
//            incrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
//            decrementButton.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 20),
//            decrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//        ])
//    }
//
//    @objc private func increment() { component.badge += 1 }
//
//    @objc private func decrement() { if component.badge != 0 { component.badge -= 1 } }
//}
