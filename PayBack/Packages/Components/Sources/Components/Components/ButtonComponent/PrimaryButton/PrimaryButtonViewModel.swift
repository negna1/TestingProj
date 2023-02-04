

import UIKit


public struct PrimaryButtonViewModel {
    
    let title: String
    let constants: PrimaryButtonConstants
    
    public static func large(title: String,
                             textColorStateEnable: UIColor =  UIColor.white,
                             textColorStatePressed: UIColor = UIColor.white,
                             textColorStateDisable: UIColor = UIColor.white,
                             backgroundColorStateEnable: UIColor = UIColor.green,
                             backgroundColorStatePressed: UIColor = UIColor.green,
                             backgroundColorStateDisable: UIColor = UIColor.green)  -> PrimaryButtonViewModel {
        
        let textColors = [ComplexButton.State.enabled: textColorStateEnable,
                          ComplexButton.State.pressed: textColorStatePressed,
                          ComplexButton.State.disable: textColorStateDisable]
        
        let backgroundColors = [ComplexButton.State.enabled: backgroundColorStateEnable,
                                ComplexButton.State.pressed: backgroundColorStatePressed,
                                ComplexButton.State.disable: backgroundColorStateDisable]
        let constants = PrimaryButtonConstantsLarge(backgroundColors: backgroundColors,
                                                    textColors: textColors)
        return PrimaryButtonViewModel(title: title, constants:constants)
    }
    
    public static func small(title: String,
                             textColorStateEnable: UIColor = UIColor.green,
                             textColorStatePressed: UIColor = UIColor.green,
                             textColorStateDisable: UIColor = UIColor.green,
                             backgroundColorStateEnable: UIColor = UIColor.green,
                             backgroundColorStatePressed: UIColor = UIColor.green,
                             backgroundColorStateDisable: UIColor = UIColor.green) -> PrimaryButtonViewModel {
        let textColors = [ComplexButton.State.enabled: textColorStateEnable,
                          ComplexButton.State.pressed: textColorStatePressed,
                          ComplexButton.State.disable: textColorStateDisable]
        
        let backgroundColors = [ComplexButton.State.enabled: backgroundColorStateEnable,
                                ComplexButton.State.pressed: backgroundColorStatePressed,
                                ComplexButton.State.disable: backgroundColorStateDisable]
        let constants = PrimaryButtonConstantsSmall(backgroundColors: backgroundColors,
                                                    textColors: textColors)
        return PrimaryButtonViewModel(title: title, constants: constants)
    }
}
