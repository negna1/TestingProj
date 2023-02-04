
import UIKit

public class RadioButton: UIView {
    
    private var onTap: ((RadioButton) -> Void)?
    public var state: RadioButton.State = .enabled() {
        didSet {
            control.configure(with: state)
        }
    }
    
    private lazy var control: RadioButtonControl = {
        let control = RadioButtonControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return control
    }()
    
    public init(model: RadioButton.ViewModel? = nil) {
        super.init(frame: .zero)
        setupView()
        if let model = model {
            configure(with: model)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    @objc private func didTap() {
        configureStateAfterTap()
        onTap?(self)
    }
    
    //MARK: View configuration
    
    public func configure(with model: RadioButton.ViewModel) {
        self.onTap = model.state.onTap
        self.state = model.state
        control.configure(with: model)
    }
    
    //MARK: View setup
    
    func setupView() {
        self.addSubview(control)
        control.stretchLayout()
    }
    
    func configureStateAfterTap() {
        switch state {
        case .enabled(let tap):
            state = .selected(onTap: tap)
        case .selected(let tap):
            state = .enabled(onTap: tap)
        case .disabled:
            break
        }
    }
}

/// This class represents RadioButtonControl. It is used by `RadioButton` component

public class RadioButtonControl: UIControl {
    
    private typealias Demensions = RadioButton.Constants.Demensions
    private typealias Fonts = RadioButton.Constants.Fonts
    private typealias Colors = RadioButton.Constants.Colors
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Demensions.stackViewSpacing
        return stackView
    }()
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.height(equalTo: Demensions.imageViewSize.height)
        imageView.width(equalTo: Demensions.imageViewSize.width)
        return imageView
    }()
    
    private let textLabel: LocalLabel = {
        let label = LocalLabel()
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.Text.enabled
        label.font = Fonts.labelFont
        return label
    }()
    
    private let labelWrapper: UIView = {
        let wrapperView = UIView()
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        return wrapperView
    }()
    
    /// Initializes and returns component with or without given model
    ///
    /// When initialized without model component can be configured by `configure(with:)` method
    
    public init(model: RadioButton.ViewModel? = nil) {
        super.init(frame: .zero)
        setupView()
        if let model = model {
            configure(with: model)
        }
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    //MARK: View configuration
    
    public func configure(with model: RadioButton.ViewModel) {
        self.textLabel.text = model.text
        self.labelWrapper.isHidden = model.text == nil
        self.configure(with: model.state)
    }
    
    public func configure(with state: RadioButton.State) {
        self.imageView.image = state.iconImage
        self.imageView.tintColor = state.iconColor
        self.textLabel.textColor = state.textLabelColor
    }
    
    //MARK: View setup
    
    private func setupView() {
        imageContainerView.addSubview(imageView)
        imageView.centerVertically(to: imageContainerView)
        imageView.centerHorizontally(to: imageContainerView)
        imageView.left(toView: imageContainerView)
        imageView.right(toView: imageContainerView)
        
        labelWrapper.addSubview(textLabel)
        textLabel.stretchLayout()
        
        stackView.addArrangedSubview(imageContainerView)
        stackView.addArrangedSubview(labelWrapper)
        self.addSubview(stackView)
        stackView.stretchLayout(with: Spacing.XS2.floatValue)
    }
}
