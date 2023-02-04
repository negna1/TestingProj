
import UIKit

public class LocalLabel: UILabel {
    
    var key: String?

    public override var text: String? {
        didSet {
            self.key = text
            super.text = Localizer.shared.localizedValue(for: key ?? "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        subscribeForChanges()
    }
    
    required init?(coder: NSCoder) {
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
        super.text = Localizer.shared.localizedValue(for: key ?? "")
    }
}
