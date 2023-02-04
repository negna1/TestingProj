
import Foundation
import UIKit

struct SecondaryButtonComponentViewModel: SecondaryButtonComponentViewModelProtocol  {
    let layout: SecondaryButtonComponentLayoutProtocol = SecondaryButtonComponentLayout()
    
    private let backgroundColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green,
    ]
    
    private let titleColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green,
    ]
    
    func iconColor(forState state: ButtonState) -> UIColor? {
        return nil
    }
    
    func borderColor(forState state: ButtonState) -> UIColor? {
        return nil
    }
    
    func backgroundColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }
    
    func titleColor(forState state: ButtonState) -> UIColor? {
        return titleColors[state.rawValue]
    }
}
