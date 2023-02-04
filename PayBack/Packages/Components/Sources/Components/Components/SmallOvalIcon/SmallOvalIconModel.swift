
import UIKit

/// Model for SmallOvalIcon component
public struct SmallOvalIconModel {
    let image: UIImage?
    let iconState: SmallOvalIconState
    
    /// - Parameters:
    ///   - image: icon image
    ///   - iconState: default value is normal
    public init(image: UIImage?,iconState: SmallOvalIconState = .normal) {
        self.image = image
        self.iconState = iconState
    }
}
