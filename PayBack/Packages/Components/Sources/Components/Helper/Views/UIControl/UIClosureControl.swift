
import UIKit

public class UIClosureControl: UIControl {

    var onTap: () -> () = {
        
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    func onTap(action: @escaping () -> ()) {
        self.onTap = action
        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTap() {
        onTap()
    }
}
