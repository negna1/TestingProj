

import UIKit

public class TextButton: LocalButton {
    
    public enum TextButtonType {
        case large
        case small
    }
    
    public var buttonState: ButtonState = .Active {
        didSet {
            handleStateChange()
        }
    }
    
    public var type: TextButtonType {
        didSet {
            handleTypeChange()
        }
    }
    
    // MARK: Initializers
    
    public convenience init() {
        self.init(title: String(), type: .large)
    }
    
    public init(title: String, type: TextButtonType) {
        self.type = type
        super.init(frame: .zero)
        configure(with: title, type: type, buttonState: buttonState)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Public properties
extension TextButton {
    
    public var title: String? {
        get { return titleLabel?.text }
        set { setTitle(newValue, for: .normal) }
    }
}

// MARK: - Configuration
extension TextButton {
    
    private func configure(with title: String, type: TextButtonType, buttonState: ButtonState) {
        setTitle(title, for: .normal)
        titleLabel?.font = type.font
        setTitleColor(buttonState.textColor, for: .normal)
    }
}

// MARK: - State change
extension TextButton {
    
    private func handleStateChange() {
        setTitleColor(buttonState.textColor, for: .normal)
    }
    
    private func handleTypeChange() {
        titleLabel?.font = type.font
    }
}

// MARK: - Touch Events
extension TextButton {
    
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
    
}

// MARK: - Helper properties
private extension ButtonState {
    
    var textColor: UIColor? {
        switch self {
        case .Active, .Pressed:
            return UIColor.green
        case .Disabled:
            return UIColor.green
        }
    }
}

private extension TextButton.TextButtonType {
    
    var font: UIFont {
        switch self {
        case .large:
            return Brandbook.Font.button2
        case .small:
            return Brandbook.Font.smallButton
        }
    }
}
