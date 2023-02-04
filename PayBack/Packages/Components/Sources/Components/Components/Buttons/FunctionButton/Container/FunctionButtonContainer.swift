

import Foundation
import UIKit

public struct ActionButtonModel {
    public let imageName: String
    public var image: UIImage? {
        return UIImage(systemName: "hand.thumbsup.fill")
    }
    public var button: FunctionButtonComponent {
        return FunctionButtonComponent(title: title, icon: image!)
    }
    public let title: String
    
    public init(title: String, imageName: String) {
        self.imageName = imageName
        self.title = title
    }
}

public class FunctionButtonContainer: UIView {

    public var duration: TimeInterval = 0.5
    public var distance: CGFloat = 64 // FIX: Function Button Height
    public var yConstraint: NSLayoutConstraint? = nil

    private let stackView: UIStackView
    private let cornerRadius: CornerRadius

    private var isUp = true

    public init(functionButtons: [FunctionButtonProtocol]) {
        self.stackView = UIStackView(arrangedSubviews: functionButtons as! [UIView])
        self.cornerRadius = .Fifty // FIXME
        super.init(frame: .zero)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .white // FIXME
        configureStackView()
        addSubview(stackView)
        wrapStackView()
    }

    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 0
    }

    private func wrapStackView() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: stackView.topAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func moveUp() {
        assert(yConstraint != nil) // Set yConstraint
        if !isUp {
            yConstraint!.constant -= distance
            layoutWithAnimation()
            isUp = true
        }
    }

    public func moveDown() {
        assert(yConstraint != nil) // Set yConstraint
        if isUp {
            yConstraint!.constant += distance
            layoutWithAnimation()
            isUp = false
        }
    }

    private func layoutWithAnimation() {
        UIView.animate(withDuration: duration, animations: {
            self.superview?.layoutIfNeeded()
        })
    }

    public override func layoutSubviews() {
        roundCorners(by: cornerRadius)
        elevate(level: .Thirty)
    }
}
