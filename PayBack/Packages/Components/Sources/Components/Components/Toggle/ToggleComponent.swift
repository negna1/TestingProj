

import UIKit

// MARK:- Toggle Component Delegate
public protocol ToggleComponentDelegate: AnyObject {
    func didChangeState(to state: ToggleComponent.ToggleState, sender: ToggleComponent)
}

// MARK:- Toggle Component
public final class ToggleComponent: UIButton {
    // MARK: Properties
    public weak var delegate: ToggleComponentDelegate?
    
    private var _toggleState: ToggleState = .inactive
    public var toggleState: ToggleState {
        get {
            _toggleState
        }
        set {
            guard newValue != _toggleState else { return }
            _toggleState = newValue
            animateTransition()
        }
    }
    public enum ToggleState: Int, CaseIterable {
        case inactive, active
        
        mutating func changeState() {
            switch self {
            case .inactive: self = .active
            case .active: self = .inactive
            }
        }
    }
    
    public var isOn: Bool { toggleState == .active }
    public var isOff: Bool { !isOn }
    
    private let circularThumb: UIView = {
        let view: UIView = .init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = ViewModel.Layout.thumbCornerRadius
        return view
    }()
    
    private var circulatThumbLeadingConstraint: NSLayoutConstraint!
    
    private let animationDuration: TimeInterval = .init(0.25)

    // MARK: Initializers
    public init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    public convenience init(delegate: ToggleComponentDelegate? = nil) {
        self.init()
        self.delegate = delegate
    }
    
    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = ViewModel.Layout.cornerRadius
        addSubViews()
        setUpLayout()
        setColors()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Setup
private extension ToggleComponent {
    func addSubViews() {
        addSubview(circularThumb)
    }
    
    func setUpLayout() {
        widthAnchor.constraint(equalToConstant: ViewModel.Layout.size.width).isActive = true
        heightAnchor.constraint(equalToConstant: ViewModel.Layout.size.height).isActive = true
        
        circularThumb.widthAnchor.constraint(equalToConstant: ViewModel.Layout.thumbSize.width).isActive = true
        circularThumb.heightAnchor.constraint(equalToConstant: ViewModel.Layout.thumbSize.height).isActive = true
        circularThumb.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        circulatThumbLeadingConstraint = circularThumb.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewModel.Layout.thumbMarginHorizontal(forState: toggleState))
        circulatThumbLeadingConstraint.isActive = true
    }
}

// MARK:- State Modification
extension ToggleComponent {
    public func changeState() {
        toggleState.changeState()
    }
    
    private func animateTransition() {
        rePositionThumb()
        UIView.animate(withDuration: animationDuration, animations: layoutIfNeeded, completion: { [weak self] _ in
            self?.setColors()
        })
    }
    
    private func rePositionThumb() {
        circulatThumbLeadingConstraint.constant = ViewModel.Layout.thumbMarginHorizontal(forState: toggleState)
    }
    
    private func setColors() {
        backgroundColor = ViewModel.backgroundColor(forState: toggleState)
        circularThumb.backgroundColor = ViewModel.thumbColor
    }
}

// MARK:- Touches
extension ToggleComponent {
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let previousState: ToggleState = toggleState
        
        changeState()
        
        if previousState != toggleState { delegate?.didChangeState(to: toggleState, sender: self) }
    }
}

// MARK:- Test
//public final class ToggleComponentTestVC: UIViewController, ToggleComponentDelegate {
//    lazy var toggle: ToggleComponent = .init(delegate: self)
//
//    lazy var buttons: UIStackView = {
//        func setUpButton(title: String, action: Selector) -> UIButton {
//            let button: UIButton = .init(frame: .zero)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.layer.cornerRadius = 5
//            button.backgroundColor = Brandbook.Color.Primary.solidDf500.uiColor,
//            button.setTitle(" \(title) ", for: .normal)
//            button.titleLabel?.font = .systemFont(ofSize: 12)
//            button.addTarget(self, action: action, for: .touchUpInside)
//            return button
//        }
//
//        let stackView: UIStackView = .init(arrangedSubviews: [
//            setUpButton(title: "Inactive", action: #selector(setInactive)),
//            setUpButton(title: "Active", action: #selector(setActive))
//        ])
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.distribution = .fillEqually
//        stackView.axis = .horizontal
//        stackView.spacing = 10
//
//        return stackView
//    }()
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = Brandbook.Color.Invert.Background.canvas.uiColor,
//
//        view.addSubview(toggle)
//        toggle.translatesAutoresizingMaskIntoConstraints = false
//        toggle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        toggle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//        view.addSubview(buttons)
//        buttons.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        buttons.topAnchor.constraint(equalTo: toggle.bottomAnchor, constant: 20).isActive = true
//    }
//
//    @objc private func setInactive() { toggle.toggleState = .inactive }
//    @objc private func setActive() { toggle.toggleState = .active }
//
//    public func didChangeState(to state: ToggleComponent.ToggleState, sender: ToggleComponent) { print(state) }
//}
