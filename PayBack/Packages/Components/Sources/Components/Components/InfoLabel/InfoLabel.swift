

import UIKit

public class InfoLabel: LocalLabel {
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    public convenience init(with title: String) {
        self.init()
        text = title
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor.gray
        font = Brandbook.Font.body2
        textAlignment = .center
    }
}
