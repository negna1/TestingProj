
import Foundation
import UIKit

protocol SmallButtonProtocol: ButtonProtocol {
    
}

protocol SmallButtonComponentViewModelProtocol: ButtonComponentViewModelProtocol {
    var layout: SmallButtonComponentLayoutProtocol { get }
    func iconColor(forState state: ButtonState) -> UIColor?
    func borderColor(forState state: ButtonState) -> UIColor?
}
