
import UIKit

public class LocalButton: UIButton {
    
    private var key : String?
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        self.key = title
        super.setTitle(
            Localizer.shared.localizedValue(for: key ?? ""),
            for: state
        )
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
        super.setTitle(
            Localizer.shared.localizedValue(for: key ?? ""),
            for: .normal
        )
    }
}
