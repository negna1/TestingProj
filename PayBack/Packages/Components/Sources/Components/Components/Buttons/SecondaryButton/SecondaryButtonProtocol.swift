
import Foundation
import UIKit

protocol SecondaryButtonProtocol: ButtonProtocol {
    
}

protocol SecondaryButtonComponentViewModelProtocol: ButtonComponentViewModelProtocol {
    var  layout: SecondaryButtonComponentLayoutProtocol { get }
    func iconColor(forState state: ButtonState) -> UIColor?
    func borderColor(forState state: ButtonState) -> UIColor?
}
