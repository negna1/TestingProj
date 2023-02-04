

import Foundation

class IconButtonComponentFactory {

    static func getViewModel(type: IconButtonComponent.ButtonType) -> IconButtonComponentViewModelProtocol {
        if type == .Small { return IconButtonSmallComponentViewModel() }
        return IconButtonNormalComponentViewModel() // if type == .Normal
    }
}
