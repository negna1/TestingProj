
import UIKit

extension RowItem {
    
    public class AmountLabel: UILabel {
        
        public override init(frame: CGRect) {
            super.init(frame: frame)            
            self.style()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func style() {
            self.textAlignment = .right
            self.font = Brandbook.Font.subtitle1
            self.textColor = UIColor.gray
        }
        
        public func configure(model: CcyAmount) {
            self.text = model.description
        }
    }
}
