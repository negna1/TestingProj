//
//import UIKit
//
//open class PlaygroundController: UIViewController {
//
//    open var iterationCount: Int = 0
//    open var didTapButton: ((Int) -> ())?
//    open var models: [Any] = []
//    open var containerView = UIView()
//    open var testImage = Brandbook.Image.Icons24.cardCreditFill.image
//    open var testImage2 = Brandbook.Image.Icons24.loanSms.image
//    open var accountCartWhite = Brandbook.Image.AccountCard.accountCardWhite.image
//    open var accountCardBlack = Brandbook.Image.AccountCard.accountCardBlack.image
//    
//    lazy var actionButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Change State", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
//        return button
//    }()
//    
//    open override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    open override func loadView() {
//        Brandbook.setTheme(.retail)
//        //FontBook.loadFonts()
//        containerView.backgroundColor = .white
//        containerView.addSubview(actionButton)
//        actionButton.centerHorizontally(to: containerView)
//        actionButton.bottom(toView: containerView, constant: 50)
//        self.view = containerView
//    }
//    
//    @objc func didTapActionButton() {
//        didTapButton?(iterationCount)
//        iterationCount = iterationCount == models.count - 1
//            ? 0
//            : iterationCount + 1
//    }
//}
