
import UIKit

extension OvalActionButton {
    /// Model for Oval action button component
    public struct ViewModel {
        let image: UIImage?
        let title: String
        let amount: String
        let type: OvalActionButton.ImageType
        let onTap: ((OvalActionButton) -> Void)?
        
        /// - Parameters:
        ///   - image: icon image
        ///   - title: text for title label
        ///   - amount: text for amount labell
        ///   - type: type of image
        ///   - onTap: closure for tap action
        public init(
            image: UIImage?,
            title: String,
            amount: String,
            type: OvalActionButton.ImageType,
            onTap: ((OvalActionButton) -> Void)? = nil) {
            
            self.image = image
            self.title = title
            self.amount = amount
            self.type = type
            self.onTap = onTap
        }
    }
}

