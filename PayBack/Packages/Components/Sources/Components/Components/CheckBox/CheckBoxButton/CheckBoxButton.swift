

import UIKit


// MARK: - Checkbox Component
final class CheckBoxButton: UIView {
    // MARK: Properties
    private let checkbox: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.layer.borderWidth = 1
        view.layer.cornerRadius = CheckBoxButton.Layout.cornerRadius
        return view
    }()
    
    private let checkmark: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = CheckBox.CheckBoxButtonConfigurations.checkmarkColor
        imageView.isUserInteractionEnabled = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: Iniitalizers
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    private func commonInit() {
        addSubViews()
        setUpLayout()
        setUpAdditionalProperties()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- Setup
private extension CheckBoxButton {
    func addSubViews() {
        self.addSubview(checkbox)
        checkbox.addSubview(checkmark)
    }
    
    func setUpAdditionalProperties() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = CheckBoxButton.Layout.cornerRadius
    }
    
    func setUpLayout() {
        self.height(equalTo: CheckBoxButton.Layout.tapAreaSize.height)
        self.width(equalTo: CheckBoxButton.Layout.tapAreaSize.width)
        
        checkbox.width(equalTo: CheckBoxButton.Layout.checkboxSize.width)
        checkbox.height(equalTo: CheckBoxButton.Layout.checkboxSize.height)
        checkbox.centerHorizontally(to: self)
        checkbox.centerVertically(to: self)
        
        checkmark.width(equalTo: CheckBoxButton.Layout.checkmarkSize.width)
        checkmark.height(equalTo: CheckBoxButton.Layout.checkmarkSize.height)
        checkmark.centerVertically(to: checkbox)
        checkmark.centerHorizontally(to: checkbox)
    }
}

// MARK:- State Modification
extension CheckBoxButton {
    func updateColors(backgroundColor: UIColor , borderColor: CGColor , image: UIImage? = nil) {
        checkbox.backgroundColor = backgroundColor
        checkbox.layer.borderColor = borderColor
        checkmark.image = image
    }
}


