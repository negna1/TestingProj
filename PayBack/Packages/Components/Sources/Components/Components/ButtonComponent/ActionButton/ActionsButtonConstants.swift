

import UIKit

protocol ActionsButtonConstants {
    var width: CGFloat { get }
    var height: CGFloat { get }
    
    var iconColors: [ComplexButton.State: UIColor] { get }
    var iconContainerColors:[ComplexButton.State: UIColor] { get }
    
    func contentViewModel(icon: UIImage, text: String) -> ActionsButtonContentViewModel
    func stateModel(for state: ComplexButton.State) -> ActionsButtonContentViewStateModel
}
