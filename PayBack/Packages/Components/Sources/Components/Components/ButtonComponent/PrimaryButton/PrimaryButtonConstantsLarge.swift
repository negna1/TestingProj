

import UIKit

struct PrimaryButtonConstantsLarge: PrimaryButtonConstants {
    let height: CGFloat = CGFloat(ButtonConstant.Primary.Large.height)
    
    let textFont: UIFont = Brandbook.Font.button1
    
    let cornerRadius: CGFloat = CGFloat(ButtonConstant.Primary.Large.cornerRadius)
    
    let loadingImage: UIImage = UIImage(systemName: "button.programmable") ?? UIImage()
    
    let loaderSize: CGFloat = CGFloat(ButtonConstant.Primary.Large.loaderSize)
    
    let backgroundColors: [ComplexButton.State: UIColor]
    let textColors: [ComplexButton.State: UIColor]
    
}
