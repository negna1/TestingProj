

import UIKit

public struct SecondaryLoadableButtonViewModel {
    
    let buttonViewModel: SecondaryButtonViewModel
    
    public static func solidTextIcon(title: String, icon: UIImage) -> SecondaryLoadableButtonViewModel {
        let buttonContentModel = SecondaryButtonViewModel.iconBadgeContentViewModel(title: title,
                                                                                    iconImage: icon,
                                                                                    badgeModel: nil)
        
        let buttonModel = SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                                   type: .solidTextIcon)
        return SecondaryLoadableButtonViewModel(buttonViewModel: buttonModel)
    }
    
    public static func solidText(title: String) -> SecondaryLoadableButtonViewModel {
        let buttonContentModel = SecondaryButtonViewModel.iconBadgeContentViewModel(title: title,
                                                                                    iconImage: nil,
                                                                                    badgeModel: nil)
        
        let buttonModel = SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                                   type: .solidText)
        return SecondaryLoadableButtonViewModel(buttonViewModel: buttonModel)
    }
    
    public static func dashTextIcon(title: String, icon: UIImage) -> SecondaryLoadableButtonViewModel {
        let buttonContentModel = SecondaryButtonViewModel.iconBadgeContentViewModel(title: title,
                                                                                    iconImage: icon)
        
        let buttonModel = SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                                   type: .dashTextIcon)
        return SecondaryLoadableButtonViewModel(buttonViewModel: buttonModel)
    }
    
    public static func dashText(title: String) -> SecondaryLoadableButtonViewModel {
        let buttonContentModel = SecondaryButtonViewModel.iconBadgeContentViewModel(title: title)
        
        let buttonModel = SecondaryButtonViewModel(buttonContentModel: buttonContentModel,
                                                   type: .dashText)
        return SecondaryLoadableButtonViewModel(buttonViewModel: buttonModel)
    }
}
