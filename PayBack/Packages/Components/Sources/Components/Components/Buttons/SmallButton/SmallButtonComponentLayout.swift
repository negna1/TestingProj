

import Foundation
import UIKit

protocol SmallButtonComponentLayoutProtocol {
    var iconSize: CGFloat { get }
    var iconPadding: CGFloat? { get }
    var contentPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var height: CGFloat { get }
    var font: UIFont { get }
}

struct SmallButtonComponentLayout: SmallButtonComponentLayoutProtocol {
    var iconPadding: CGFloat?
    let iconSize = CGFloat(integerLiteral: 16)
    let contentPadding = CGFloat(integerLiteral: 25)
    let cornerRadius = CGFloat(0.50)
    let borderWidth = CGFloat(integerLiteral: 2)
    let height = CGFloat(integerLiteral: 32)
    let font =  Brandbook.Font.button2
}

struct SmallIconButtonComponentLayout: SmallButtonComponentLayoutProtocol {
    let iconSize = CGFloat(integerLiteral: 10)
    let contentPadding = CGFloat(integerLiteral: 14)
    var iconPadding: CGFloat? = CGFloat(integerLiteral: 7)
    let cornerRadius = CGFloat(0.50)
    let borderWidth = CGFloat(integerLiteral: 2)
    let height = CGFloat(integerLiteral: 32)
    let font =  Brandbook.Font.button2
}
