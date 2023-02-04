

import Foundation
import UIKit
struct SecondaryIconedDashedButtonComponentViewModel: SecondaryButtonComponentViewModelProtocol  {
    let layout: SecondaryButtonComponentLayoutProtocol = SecondaryButtonComponentLayout()
    
    private let backgroundColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green
    ]
    
    private let titleColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green
    ]
    
    private let iconColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green
    ]
    
    private let borderColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green
    ]
    
    
    func iconColor(forState state: ButtonState) -> UIColor? {
        return iconColors[state.rawValue]
    }
    
    func borderColor(forState state: ButtonState) -> UIColor? {
        return borderColors[state.rawValue]
    }
    
    func backgroundColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }
    
    func titleColor(forState state: ButtonState) -> UIColor? {
        return titleColors[state.rawValue]
    }
}
