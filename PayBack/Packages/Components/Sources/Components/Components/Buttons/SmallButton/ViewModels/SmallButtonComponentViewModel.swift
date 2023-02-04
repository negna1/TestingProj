

import Foundation
import UIKit

struct SmallButtonComponentViewModel:
SmallButtonComponentViewModelProtocol {
    let layout: SmallButtonComponentLayoutProtocol = SmallButtonComponentLayout()
    
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
        nil
    }
    
    func borderColor(forState state: ButtonState) -> UIColor? {
        nil
    }
    
    func backgroundColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }
    
    func titleColor(forState state: ButtonState) -> UIColor? {
        return titleColors[state.rawValue]
    }
}
