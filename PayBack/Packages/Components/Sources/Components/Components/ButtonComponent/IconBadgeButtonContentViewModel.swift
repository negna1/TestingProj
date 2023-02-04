

import UIKit

struct IconBadgeButtonContentViewStateModel: ComplexButtonContentViewModel {
    let textColor: UIColor
    let badgeAlpha: CGFloat
    
    init(textColor: UIColor, badgeAlpha: Double) {
        self.textColor = textColor
        self.badgeAlpha = CGFloat(badgeAlpha)
    }
}

struct IconBadgeButtonContentViewModel {
    
    let title: String
    let textFont: UIFont
    let iconImage: UIImage?
    let badgeModel: BadgeModel?
    let iconBadgeInverted: Bool
    let iconDistance:CGFloat
    let badgeDistance:CGFloat
    let minContentHorizontalPaddings: CGFloat
    
    init(title: String,
         textFont: UIFont,
         iconImage: UIImage? = nil,
         badgeModel: BadgeModel? = nil,
         iconBadgeInverted: Bool = false,
         iconDistance: Double,
         badgeDistance: Double,
         minContentHorizontalPaddings: Double) {
        self.title = title
        self.iconImage = iconImage
        self.badgeModel = badgeModel
        self.iconBadgeInverted = iconBadgeInverted
        self.iconDistance = CGFloat(iconDistance)
        self.badgeDistance = CGFloat(badgeDistance)
        self.textFont = textFont
        self.minContentHorizontalPaddings = CGFloat(minContentHorizontalPaddings)
    }
}
