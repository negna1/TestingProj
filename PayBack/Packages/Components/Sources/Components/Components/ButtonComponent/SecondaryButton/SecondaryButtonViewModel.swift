

import UIKit

public struct SecondaryButtonViewModel {
    
    let buttonContentModel: IconBadgeButtonContentViewModel
    
    let type: SecondaryButtonType
    
    public static func solidTextIcon(title: String,
                                      icon: UIImage) -> SecondaryButtonViewModel {
        let buttonContentModel = iconBadgeContentViewModel(title: title,
                                                           iconImage: icon,
                                                           badgeModel: nil)
        
        return SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                        type: .solidTextIcon)
    }
    
    public static func solidText(title: String) -> SecondaryButtonViewModel {
        let buttonContentModel = iconBadgeContentViewModel(title: title)
        
        return SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                        type: .solidText)
    }
    
    public static func solidTextIconBadge(title: String,
                                          icon: UIImage,
                                          badgeModel:BadgeModel) -> SecondaryButtonViewModel {
        let buttonContentModel = iconBadgeContentViewModel(title: title,
                                                           iconImage: icon,
                                                           badgeModel: badgeModel)
        
        return SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                        type: .solidTextIconBadge)
    }
    
    public static func solidTextBadge(title: String,
                                      badgeModel:BadgeModel) -> SecondaryButtonViewModel {
        let buttonContentModel = iconBadgeContentViewModel(title: title,
                                                           iconImage: nil,
                                                           badgeModel: badgeModel)
        
        return SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                        type: .solidTextBadge)
    }
    
    public static func dashTextIconBadge(title: String,
                                         icon: UIImage,
                                         badgeModel:BadgeModel) -> SecondaryButtonViewModel {
        let buttonContentModel = iconBadgeContentViewModel(title: title,
                                                           iconImage: icon,
                                                           badgeModel: badgeModel)
        
        return SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                        type: .dashTextIconBadge)
    }
    
    public static func dashTextBadge(title: String,
                                      badgeModel:BadgeModel) -> SecondaryButtonViewModel {
        let buttonContentModel = iconBadgeContentViewModel(title: title,
                                                           iconImage: nil,
                                                           badgeModel: badgeModel)
        
        return SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                        type: .dashTextBadge)
    }
    
    static func iconBadgeContentViewModel(title: String,
                                          iconImage: UIImage? = nil,
                                          badgeModel: BadgeModel? = nil) -> IconBadgeButtonContentViewModel {
        return IconBadgeButtonContentViewModel(title: title,
                                               textFont: Brandbook.Font.smallButton,
                                               iconImage: iconImage,
                                               badgeModel: badgeModel,
                                               iconBadgeInverted: false,
                                               iconDistance: Double(ButtonConstant.Secondary.iconDistance),
                                               badgeDistance: Double(ButtonConstant.Secondary.badgeDistance),
                                               minContentHorizontalPaddings: Double(ButtonConstant.Secondary.contenntHorizontalOffsetMin))
    }
}
