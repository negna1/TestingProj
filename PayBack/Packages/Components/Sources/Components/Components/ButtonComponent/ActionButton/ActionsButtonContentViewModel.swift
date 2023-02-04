
import UIKit

struct ActionsButtonContentViewStateModel: ComplexButtonContentViewModel {
    let iconColor: UIColor
    let iconContainerColor: UIColor
    let iconContainerBorderColor: UIColor
    let textColor: UIColor
    
    init(iconColor: UIColor,
         iconContainerColor: UIColor,
         iconContainerBorderColor: UIColor,
         textColor: UIColor) {
        self.iconColor = iconColor
        self.iconContainerColor = iconContainerColor
        self.iconContainerBorderColor = iconContainerBorderColor
        self.textColor = textColor
    }
}

struct ActionsButtonContentViewModel {
    
    let text: String
    let image: UIImage
    let iconContainerSize: Double
    let iconContainerCornerRadius: Double
    let isCloseIconVisible: Bool
    let amountText: String?
    
    init(text: String,
         image: UIImage,
         iconContainerSize: Double,
         iconContainerCornerRadius: Double,
         isCloseIconVisible: Bool = false,
         amountText: String? = nil) {
        self.text = text
        self.image = image
        self.iconContainerSize = iconContainerSize
        self.iconContainerCornerRadius = iconContainerCornerRadius
        self.isCloseIconVisible = isCloseIconVisible
        self.amountText = amountText
    }
}
