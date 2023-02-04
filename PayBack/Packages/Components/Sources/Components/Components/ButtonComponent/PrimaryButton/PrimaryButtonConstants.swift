

import UIKit

protocol PrimaryButtonConstants {
    var height: CGFloat{ get }

    var textFont: UIFont { get }
    
    var cornerRadius: CGFloat { get }
    
    var loadingImage: UIImage { get }
    
    var loaderSize: CGFloat { get }
    
    var backgroundColors: [ComplexButton.State: UIColor] { get }
    var textColors: [ComplexButton.State: UIColor] { get }
}
