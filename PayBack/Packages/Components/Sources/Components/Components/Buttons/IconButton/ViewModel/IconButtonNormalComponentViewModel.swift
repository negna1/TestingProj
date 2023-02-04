

import Foundation
import UIKit

struct IconButtonNormalComponentViewModel: IconButtonComponentViewModelProtocol {

    let layout: IconButtonComponentLayoutProtocol = IconButtonNormalComponentLayout()

    private let backgroundColors: [UIColor?] = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange,
    ]

    private let iconColors: [UIColor?] = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange,
    ]

    func backgroundColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }

    func iconColor(forState state: ButtonState) -> UIColor? {
        return iconColors[state.rawValue]
    }

    func borderColor(forState state: ButtonState) -> UIColor? {
        return iconColors[state.rawValue]
    }

    func titleColor(forState state: ButtonState) -> UIColor? {
        return nil
    }
}
