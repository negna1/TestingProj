
import UIKit

class LocalCopyableLabel: LocalLabel {
    
    public var isCopyingEnabled: Bool = false {
        didSet {
            updateCopying()
        }
    }
    
    lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        let recognizer = UILongPressGestureRecognizer(target: self,
                                                      action: #selector(longPressRecognized))
        return recognizer
    }()
    
    @objc func longPressRecognized(sender: UIGestureRecognizer) {
        
  
        if sender.state == .began {
            becomeFirstResponder()
            
            let frame = textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
            let copyMenu = UIMenuController.shared
            copyMenu.arrowDirection = .default
            if #available(iOS 13.0, *) {
                copyMenu.showMenu(from: self, rect: frame )
            } else {
                // Fallback on earlier versions
                copyMenu.setTargetRect(frame, in: self)
                copyMenu.setMenuVisible(true, animated: true)
            }
            print("long press")
        }
    }
    
    @objc
    public override var canBecomeFirstResponder: Bool {
        return isCopyingEnabled
    }

    @objc
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        // Only return `true` when it's the copy: action AND the `copyingEnabled` property is `true`.
        return (action == #selector(self.copy(_:)) && isCopyingEnabled)
    }

    @objc
    public override func copy(_ sender: Any?) {
        if isCopyingEnabled {
            // Copy the label text
            let pasteboard = UIPasteboard.general
            pasteboard.string = text
        }
    }
    
    func updateCopying() {
        
        if isCopyingEnabled {
            addGestureRecognizer(self.longPressRecognizer)
            isUserInteractionEnabled = true
        } else {
            removeGestureRecognizer(self.longPressRecognizer)
            isUserInteractionEnabled = false
        }
        
    }
}
