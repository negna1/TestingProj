

import Foundation
import UIKit
protocol SecondaryButtonComponentLayoutProtocol {
    var iconSize: CGFloat { get}
    var contentPadding: CGFloat { get }
    var iconPadding: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var dashPattern: [NSNumber] { get }
    var borderWidth: CGFloat { get }
    var font: UIFont { get }
}

struct SecondaryButtonComponentLayout: SecondaryButtonComponentLayoutProtocol {
    let iconSize = CGFloat(integerLiteral: 16)
    let contentPadding = CGFloat(integerLiteral: 24)
    let iconPadding = CGFloat(integerLiteral: 12)
    let cornerRadius = CGFloat(0.25)
    let dashPattern:[NSNumber] = [5, 5]
    let borderWidth = CGFloat(integerLiteral: 2)
    let font = Brandbook.Font.smallButton
}
