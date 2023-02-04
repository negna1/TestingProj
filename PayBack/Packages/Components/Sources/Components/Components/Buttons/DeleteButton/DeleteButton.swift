

import UIKit

//public class DeleteButton: UIButton {
//    
//    private let size: CGSize = .init(width: 56, height: 56)
//    
//    // MARK: - Changing Colors For Different States
//    public override var isHighlighted: Bool {
//        didSet {
//            backgroundColor = isHighlighted ? TransferButtonConsts.pressedBackgroundColor : TransferButtonConsts.activeBackgroundColor
//            tintColor = isHighlighted ? TransferButtonConsts.pressedIconColor : TransferButtonConsts.activeIconColor
//        }
//    }
//    public override var isEnabled: Bool {
//        didSet {
//            backgroundColor = isEnabled ? TransferButtonConsts.activeBackgroundColor : TransferButtonConsts.inActiveBakgroundColor
//            tintColor = isEnabled ? TransferButtonConsts.activeIconColor : TransferButtonConsts.inactiveIconColor
//        }
//    }
//    
//    public var tapped: (() -> Void)?
//    private let iconString = Brandbook.Image.Icons24.systemDelete.designSystemName
//    
//    public override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//    }
//    
//    public required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        configure()
//    }
//    
//    public init(tapped: (() -> Void)? = nil) {
//        super.init(frame: .zero)
//        self.tapped = tapped
//        configure()
//    }
//    
//    public override func layoutSubviews() {
//        super.layoutSubviews()
//        roundCorners(by: .Forty)
//    }
//    
//    private func configure() {
//        configureIcon()
//        configureTarget()
//        width(equalTo: size.width)
//        height(equalTo: size.height)
//    }
//    
//    private func configureIcon() {
//        let image = UIImage(named: iconString, in: ImageBook.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
//        self.setImage(image, for: .normal)
//        self.tintColor = TransferButtonConsts.activeIconColor
//        backgroundColor = TransferButtonConsts.activeBackgroundColor
//    }
//    
//    private func configureTarget() {
//        addTarget(self, action: #selector(didTap), for: .touchUpInside)
//    }
//    
//    @objc private func didTap() {
//        self.tapped?()
//    }
//}
