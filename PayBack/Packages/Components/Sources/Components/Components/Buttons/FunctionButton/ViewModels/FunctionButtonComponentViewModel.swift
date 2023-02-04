
import Foundation
import UIKit

struct FunctionButtonComponentViewModel: FunctionButtonComponentViewModelProtocol {

    var layout: FunctionButtonComponentLayoutProtocol = FunctionButtonComponentLayout()

    private let iconColors = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange,
    ]

    private let backgroundColors = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange
    ]

    private let titleColors = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange
    ]

    func iconColor(forState state: ButtonState) -> UIColor? {
        return iconColors[state.rawValue]
    }
    
    func titleColor(forState state: ButtonState) -> UIColor? {
        return titleColors[state.rawValue]
    }

    func backgroundColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }
}
