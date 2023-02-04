

//import UIKit
//
//class CheckBoxWrapper: UIView {
//    
//    private lazy var checkbox: CheckBox = {
//        let c = CheckBox()
//        c.translatesAutoresizingMaskIntoConstraints = false
//        return c
//    }()
//
//    init() {
//        super.init(frame: .zero)
//        addSubview(checkbox: checkbox)
//        configureConstraints()
//    }
//    
//    private func addSubview(checkbox: CheckBox) {
//        self.addSubview(checkbox)
//    }
//    
//    private func configureConstraints() {
//        checkbox.centerHorizontally(to: self)
//        checkbox.top(toView: self)
//        checkbox.bottom(toView: self)
//        checkbox.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 0).isActive = true
//        checkbox.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 0).isActive = true
//    }
//    
//    public func configure(withCheckbox type: CheckBox.ModelType) {
//        self.checkbox.configure(type: type)
//    }
//    
//    public func set(delegate: CheckBoxDelegate?) {
//        self.checkbox.delegate = delegate
//    }
//
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
