

import Foundation
import UIKit
public protocol IconButtonProtocol {
    func setIcon(_ icon: UIImage, iconTint: UIColor?)
}

protocol IconButtonComponentViewModelProtocol: ButtonComponentViewModelProtocol {
    var layout: IconButtonComponentLayoutProtocol { get }
    func iconColor(forState state: ButtonState) -> UIColor?
    func borderColor(forState state: ButtonState) -> UIColor?
}
