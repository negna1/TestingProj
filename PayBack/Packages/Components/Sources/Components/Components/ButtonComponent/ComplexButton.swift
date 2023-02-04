
import UIKit

protocol ComplexButtonContentViewModel {
    
}

protocol ComplexButtonContentView: UIView {
    
    func configureState(model: ComplexButtonContentViewModel)
}

class ComplexButton: UIControl {
    
    static let defaultBorderColor = UIColor.clear
    static let defaultFillColor = UIColor.clear
    
    enum State: String {
        case enabled
        case pressed
        case disable
    }
    
    struct BorderStyle {
        public static let dash: BorderStyle = BorderStyle(pattern: [4, 4])
        public static let solid: BorderStyle = BorderStyle(pattern: [])
        
        let pattern:[NSNumber]
    }
    
    // MARK: - Accessors
    var cornerRadius: CGFloat = .zero {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    var borderWidth: CGFloat = .zero {
        didSet {
            self.borderLayer.lineWidth = borderWidth
        }
    }
    
    var borderStyle: BorderStyle = .solid {
        didSet {
            self.borderLayer.lineDashPattern = borderStyle.pattern
        }
    }
    
    var borderColor: UIColor = ComplexButton.defaultBorderColor {
        didSet {
            self.borderLayer.strokeColor = borderColor.cgColor
        }
    }
    
    var fillColor: UIColor = ComplexButton.defaultFillColor {
        didSet {
            self.borderLayer.fillColor = fillColor.cgColor
        }
    }
    
    // MARK: - Properties
    var contentView: ComplexButtonContentView!
    
    var borderColors: [State :UIColor] = [:] { didSet { updateStates() } }
    var backgroundColors: [State: UIColor] = [:] { didSet { updateStates() } }
    var contentConfigurations: [State: ComplexButtonContentViewModel] = [:] { didSet { updateStates() } }
    
    var borderLayer: CAShapeLayer = CAShapeLayer()
    
    // MARK: - Initializers
    convenience init(contentView: ComplexButtonContentView) {
        
        self.init(frame: .zero)
        self.contentView = contentView
        self.setup()
    }
    
    // MARK: - Internal methods
    private func setup() {
        setupView()
        setupBorderLayer()
        setupContentView()
    }
    
    private func setupContentView() {
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftNotSafe(toView: self)
        //contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.rightNotSafe(toView: self)
        //contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topNotSafe(toView: self)
        //contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomNotSafe(toView: self)
        //contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.fillColor = .clear
    }
    
    private func setupBorderLayer() {
        self.layer.addSublayer(borderLayer)
    }
    
    private func updateStates() {
        self.displayPressStyle(pressed: self.isHighlighted)
        self.displayEnableStyle(enable: self.isEnabled)
    }
    
    private func displayPressStyle(pressed: Bool) {
        let state = pressed ? State.pressed : State.enabled
        self.borderColor = self.borderColors[state] ?? ComplexButton.defaultBorderColor
        self.fillColor = self.backgroundColors[state] ?? ComplexButton.defaultFillColor
        self.displayContentConfiguration(state:state)
    }
    
    private func displayEnableStyle(enable: Bool) {
        let state = enable ? State.enabled : State.disable
        self.borderColor = self.borderColors[state] ?? ComplexButton.defaultBorderColor
        self.fillColor = self.backgroundColors[state] ?? ComplexButton.defaultFillColor
        self.displayContentConfiguration(state:state)
    }
    
    private func displayContentConfiguration(state:State) {
        if let model = self.contentConfigurations[state] {
            self.contentView.configureState(model: model)
        }
    }
    
    // MARK: - Modifyers
    func setBorderColor(color:UIColor, for state: State) {
        self.borderColors[state] = color
    }
    
    func setBackroundColor(color:UIColor, for state: State) {
        self.backgroundColors[state] = color
    }
    
    func setContentConfiguration(model: ComplexButtonContentViewModel, for state: State) {
        self.contentConfigurations[state] = model
        
    }
    
    // MARK: - UIView
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}

// MARK: - UIControl States Handling
extension ComplexButton {
    
    override var isHighlighted: Bool {
        didSet {
            if oldValue != self.isHighlighted &&  self.isEnabled {
                self.displayPressStyle(pressed: self.isHighlighted)
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            if oldValue != self.isEnabled {
                self.displayEnableStyle(enable: self.isEnabled)
            }
        }
    }
}
