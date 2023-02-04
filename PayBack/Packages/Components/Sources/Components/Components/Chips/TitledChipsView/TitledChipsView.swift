
import UIKit
/**
 This Component is not from zepplin, this is container class for chipsView and Info label, for using in FixedButtonContainer as "TopElement"
 */
public class TitledChipsView: UIView {
    // MARK: - Properties
    private var textLabel: LocalLabel = {
        let lbl = LocalLabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.green
        lbl.font = Brandbook.Font.body2
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var chipsView: ChipsView = {
        let chipsView = ChipsView()
        chipsView.translatesAutoresizingMaskIntoConstraints = false
        return chipsView
    }()
    
    private var didChangeIndex: ((_ index: Int) -> Void)?
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    convenience init(model: TitledChipsViewModel) {
        self.init()
        configure(viewModel: model)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        addSubview(textLabel)
        addSubview(chipsView)
        textLabel.top(toView: self, constant: Spacing.S.floatValue)
        textLabel.left(toView: self, constant: Spacing.M.floatValue)
        textLabel.right(toView: self, constant: Spacing.M.floatValue)
        chipsView.left(toView: self)
        chipsView.right(toView: self)
        chipsView.relativeTop(toView: textLabel, constant: Spacing.S.floatValue)
        chipsView.height(equalTo: 32)
        chipsView.bottom(toView: self)
    }
    
    // MARK: - Public Configuration
    public func configure(viewModel: TitledChipsViewModel) {
        textLabel.text = viewModel.infoText
        chipsView.configure(viewModel: viewModel.chipsViewModel)
    }
}
 
