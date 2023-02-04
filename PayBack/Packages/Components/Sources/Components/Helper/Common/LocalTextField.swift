
import UIKit


open class LocalTextField: UITextField {
    
    open var key: String?
    open var placeholderKey: String?
    open var attributes: [NSAttributedString.Key: Any]?
    
    open override var text: String? {
        didSet {
            // self.key = text
            // super.text = Localizer.shared.localizedValue(for: key ?? "")
        }
    }
    
    public func set(attributed text: String, with attributes: [NSAttributedString.Key: Any]?) {
        self.placeholderKey = text
        self.attributes = attributes
        super.attributedText = NSAttributedString(string: Localizer.shared.localizedValue(for: text),
                                                 attributes: attributes)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subscribeForChanges()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribeForChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLocalizationChanges),
            name: Notification.Name("LanguageChanged"),
            object: nil)
    }
    
    @objc func handleLocalizationChanges() {
        set(
            attributed: Localizer.shared.localizedValue(for: placeholderKey ?? ""),
            with: attributes
        )
    }
}
