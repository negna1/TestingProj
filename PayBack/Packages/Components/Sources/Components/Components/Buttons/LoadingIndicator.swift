

import UIKit

public protocol LoadingIndictable: AnyObject {
    
    var indicationImage:UIImage { get }
    var contentView:UIView { get }
    func enableInteraction()
    func disableInteraction()
}

open class LoadingIndicator {
    
    public enum LoaderAlignment {
        case left
        case right
        case top
        case buttom
        case fill
    }
    
    lazy var loadingView = UIImageView()
    
    weak var decoratableView:LoadingIndictable?
    
    public init() {
        
    }
    
    private func configureLoadinView(position:CGPoint) {
        
        if let contentView = decoratableView?.contentView {
            contentView.addSubview(loadingView)
            let leadingOffset = position.x - loadingView.intrinsicContentSize.width / 2
            let topOffset = position.y - loadingView.intrinsicContentSize.height / 2
            loadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingOffset).isActive = true
            loadingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topOffset).isActive = true
            loadingView.widthAnchor.constraint(equalToConstant: loadingView.intrinsicContentSize.width).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: loadingView.intrinsicContentSize.height).isActive = true
        }
    }
    
    private func placeLoadingView(alligned:LoaderAlignment, offset:CGFloat) {
        
        if let contentView = decoratableView?.contentView {
            contentView.addSubview(loadingView)
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            loadingView.widthAnchor.constraint(equalToConstant: loadingView.intrinsicContentSize.width).isActive = true
            loadingView.heightAnchor.constraint(equalToConstant: loadingView.intrinsicContentSize.height).isActive = true
            
            switch alligned {
            case .left:
                loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                loadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset).isActive = true
            case .right:
                loadingView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
                loadingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset).isActive = true
            case .top:
                loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                loadingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offset).isActive = true
            case .buttom:
                loadingView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                loadingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offset).isActive = true
            case .fill:
                loadingView.stretchLayout()
            }
        }
    }
    
    private func configureAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue =  Double.pi * 2.0
        animation.duration = 2
        animation.repeatCount = .infinity
        animation.isRemovedOnCompletion = false

        loadingView.layer.add(animation, forKey: "spin")
    }
    
    public func addIndication(forIndicatable: LoadingIndictable, alignment: LoaderAlignment = .right,offset: CGFloat = 0) {
        
        if decoratableView != nil { removeIndication() }
        decoratableView = forIndicatable
        
        loadingView.image = forIndicatable.indicationImage
        placeLoadingView(alligned: alignment, offset: offset)
        configureAnimation()
        
        
        forIndicatable.disableInteraction()
        
    }
    
    public func removeIndication() {
        decoratableView?.enableInteraction()
        decoratableView = nil
        loadingView.removeFromSuperview();
    }
    
}
