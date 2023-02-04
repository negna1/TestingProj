

//import UIKit
//
//public class UIControlWrapper<T: UIControl & Configurable>: UIView {
//
//    public var onTap: ((UIControlWrapper) -> Void)?
//    private lazy var control: T = {
//        let control = T()
//        control.addTarget(self, action: #selector(didTap), for: .touchUpInside)
//        control.translatesAutoresizingMaskIntoConstraints = false
//        return control
//    }()
//    
//    public init(controlModel: T.Model? = nil) {
//        super.init(frame: .zero)
//        setupView()
//        if let model = controlModel {
//            configure(with: model)
//        }
//    }
//    
//    public required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    @objc private func didTap() {
//        onTap?(self)
//    }
//    
//    public func configure(with model: T.Model) {
//        control.configure(with: model)
//    }
//    
//    func setupView() {
//        self.addSubview(control)
//        control.stretchLayout()
//    }
//}
