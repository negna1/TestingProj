
import UIKit

// MARK:- Small Icon Text Button Component
public final class SmallIconTextButtonComponent: LocalButton {
    // MARK: Properties
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
    
    private lazy var iconImageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = icon
        return imageView
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
    
    private typealias VM = SmallIconTextButtonComponentViewModel
    
    // MARK: Initializers
    public init(icon: UIImage?, title: String) {
        self.icon = icon
        self.title = title
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Setup
private extension SmallIconTextButtonComponent {
    func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setUpLayout()
        reflectStateChange()
    }
    
    func addSubviews() {
        addSubview(background)
        background.addSubview(iconImageView)
        background.addSubview(label)
    }
    
    func setUpLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: VM.Layout.height),
            
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: VM.Layout.iconSize.width),
            iconImageView.heightAnchor.constraint(equalToConstant: VM.Layout.iconSize.height),
            iconImageView.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: VM.Layout.iconMarginLeading),
            iconImageView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            
            label.heightAnchor.constraint(equalToConstant: VM.Layout.labelHeight),
            label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: VM.Layout.labelMarginLeading),
            label.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: VM.Layout.labelMarginTrailing),
            label.centerYAnchor.constraint(equalTo: background.centerYAnchor)
        ])
    }
}

// MARK:- State Change
private extension SmallIconTextButtonComponent {
    func reflectStateChange() {
        background.backgroundColor = VM.Color.background(for: buttonState)
        iconImageView.tintColor = VM.Color.foreground(for: buttonState)
        label.textColor = VM.Color.foreground(for: buttonState)
    }
}

// MARK:- Touches
extension SmallIconTextButtonComponent {
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
