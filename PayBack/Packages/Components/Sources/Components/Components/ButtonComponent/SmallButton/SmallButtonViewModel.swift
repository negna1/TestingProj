

import UIKit


/** FIXME
 
    The final version should look like this
 
    let button = SmallButton(type: .border(title: "Next"))
    let button = SmallButton(type: .textIcon(title: "Next", icon: UIImage(named: "icon")))
 
    Use enum associated values instead of static functions in model
 */


public struct SmallButtonViewModel {
    
    let buttonContentModel: IconBadgeButtonContentViewModel
    let type: SmallButtonType
    
    public static func border(title: String)  -> SmallButtonViewModel {
        
        let buttonContentModel = IconBadgeButtonContentViewModel(title: title,
                                                                 textFont: Brandbook.Font.button2,
                                                                 iconDistance: .zero,
                                                                 badgeDistance: .zero,
                                                                 minContentHorizontalPaddings: ButtonConstant.Small.Border.contenntHorizontalOffsetMin)
        
        return SmallButtonViewModel(buttonContentModel: buttonContentModel,
                                    type: .border)
    }
    
    public static func text(title: String)  -> SmallButtonViewModel {
        
        let buttonContentModel = IconBadgeButtonContentViewModel(title: title,
                                                                 textFont: Brandbook.Font.button2,
                                                                 iconDistance: .zero,
                                                                 badgeDistance: .zero,
                                                                 minContentHorizontalPaddings: ButtonConstant.Small.Text.contenntHorizontalOffsetMin)
        
        return SmallButtonViewModel(buttonContentModel: buttonContentModel,
                                    type: .text)
        
    }
    
    public static func textIcon(title: String,
                                icon:UIImage,
                                iconAndTitleTint: UIColor? = nil,
                                backgroundTint: UIColor? = nil)  -> SmallButtonViewModel {
        let buttonContentModel = IconBadgeButtonContentViewModel(title: title,
                                                                 textFont: Brandbook.Font.button2,
                                                                 iconImage: icon,
                                                                 iconBadgeInverted: true,
                                                                 iconDistance: ButtonConstant.Small.TextIcon.iconDistance,
                                                                 badgeDistance: .zero,
                                                                 minContentHorizontalPaddings: ButtonConstant.Small.TextIcon.contenntHorizontalOffsetMin)
        
        return SmallButtonViewModel(buttonContentModel: buttonContentModel,
                                    type: .textIcon(titleAndIconTint: iconAndTitleTint, backgroundTint: backgroundTint))
    }
    
    public static func iconText(icon:UIImage, title: String)  -> SmallButtonViewModel {
        
        let buttonContentModel = IconBadgeButtonContentViewModel(title: title,
                                                                 textFont: Brandbook.Font.button2,
                                                                 iconImage: icon,
                                                                 iconDistance: ButtonConstant.Small.IconText.iconDistance,
                                                                 badgeDistance: .zero,
                                                                 minContentHorizontalPaddings: ButtonConstant.Small.IconText.contenntHorizontalOffsetMin)
        
        return SmallButtonViewModel(buttonContentModel: buttonContentModel,
                                    type: .iconText)
    }
    
    public static func iconTextWhite(icon:UIImage, title: String)  -> SmallButtonViewModel {
        
        let buttonContentModel = IconBadgeButtonContentViewModel(title: title,
                                                                 textFont: Brandbook.Font.button2,
                                                                 iconImage: icon,
                                                                 iconDistance: ButtonConstant.Small.IconTextWhite.iconDistance,
                                                                 badgeDistance: .zero,
                                                                 minContentHorizontalPaddings: ButtonConstant.Small.IconTextWhite.contenntHorizontalOffsetMin)
        
        return SmallButtonViewModel(buttonContentModel: buttonContentModel,
                                    type: .iconTextWhite)
        
    }
    
    public static func textIconBadge(badgeModel: BadgeModel, title: String, icon:UIImage)  -> SmallButtonViewModel {
        
        let buttonContentModel = IconBadgeButtonContentViewModel(title: title,
                                                                 textFont: Brandbook.Font.button2,
                                                                 iconImage: icon,
                                                                 badgeModel: badgeModel,
                                                                 iconBadgeInverted: true,
                                                                 iconDistance: ButtonConstant.Small.TextIconBadge.iconDistance,
                                                                 badgeDistance: ButtonConstant.Small.TextIconBadge.badgeDistance,
                                                                 minContentHorizontalPaddings: ButtonConstant.Small.TextIconBadge.contenntHorizontalOffsetMin)
        
        return SmallButtonViewModel(buttonContentModel: buttonContentModel,
                                    type: .textIconBadge)
        
    }
}
