

import Foundation
import UIKit

public protocol FunctionButtonProtocol {
    func setContentTitle(title: String)
    func setContentIcon(iconName: String)
}

/* FIXME: Bad Procotol Naming.
          Protocol Names Should Not Contain 'Protocol'. */
protocol FunctionButtonComponentViewModelProtocol: ButtonComponentViewModelProtocol {
    var layout: FunctionButtonComponentLayoutProtocol { get }
    func iconColor(forState state: ButtonState) -> UIColor?
}
