

import UIKit

struct PrimaryButtonConstantsSmall: PrimaryButtonConstants {
    let height: CGFloat = CGFloat(ButtonConstant.Primary.Small.height)
    
    let textFont: UIFont = Brandbook.Font.button2
    
    let cornerRadius: CGFloat = CGFloat(ButtonConstant.Primary.Small.cornerRadius)
    
    let loadingImage: UIImage = UIImage(systemName: "button.programmable") ?? UIImage()
    
    let loaderSize: CGFloat = CGFloat(ButtonConstant.Primary.Small.loaderSize)
    
    let backgroundColors: [ComplexButton.State: UIColor]
    let textColors: [ComplexButton.State: UIColor]
    
}
