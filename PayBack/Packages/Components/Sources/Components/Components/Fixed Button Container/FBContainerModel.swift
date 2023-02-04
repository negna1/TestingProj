

import UIKit

public class FBContainerModel {
    var buttonTitle: String
    var topElement: FixedButtonContainer.TopElement?
    var leftElement: FixedButtonContainer.LeftElement?
    var bottomElement: FixedButtonContainer.BottomElement?
    var hasSeparator: Bool
    var onTap: ((PrimaryButtonComponent) -> ())?
    
    public init(
        buttonTitle: String,
        topElement: FixedButtonContainer.TopElement? = nil,
        leftElement: FixedButtonContainer.LeftElement? = nil,
        bottomElement: FixedButtonContainer.BottomElement? = nil,
        hasSeparator: Bool = true,
        onTap: ((PrimaryButtonComponent) -> ())? = nil) {
        
        self.buttonTitle = buttonTitle
        self.topElement = topElement
        self.leftElement = leftElement
        self.bottomElement = bottomElement
        self.hasSeparator = hasSeparator
        self.onTap = onTap
    }
}
