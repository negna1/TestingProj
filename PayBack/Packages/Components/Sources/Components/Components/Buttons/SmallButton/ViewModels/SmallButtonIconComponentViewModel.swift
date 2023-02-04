

import Foundation
import UIKit

struct SmallButtonIconComponentViewModel: SmallButtonComponentViewModelProtocol {
    let layout: SmallButtonComponentLayoutProtocol = SmallIconButtonComponentLayout()
    
    private let iconColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green
    ]
    
    private let backgroundColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green,
    ]
    private let titleColors: [UIColor?] = [
        UIColor.green,
        UIColor.green,
        UIColor.green
    ]
    func iconColor(forState state: ButtonState) -> UIColor? {
        return iconColors[state.rawValue]
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
