
import UIKit
import SDWebImage

public class RowImageView: UIImageView {
    
    public typealias T = RowImageView.`Type`
    
    public init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    public convenience init(type: T) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        setUpImageFrame(with: type.size)
        roundImage(for: type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpImageFrame(with size: CGSize) {
        self.width(equalTo: size.width)
        self.height(equalTo: size.height)
    }
    
    private func roundImage(for type: T) {
        self.layer.cornerRadius = type == .roundedImage
            ? self.frame.height / 2
            : 0
    }
}
