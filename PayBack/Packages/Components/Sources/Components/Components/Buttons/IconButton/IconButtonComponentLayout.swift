

import Foundation
import UIKit
protocol IconButtonComponentLayoutProtocol {
    var iconSize: CGFloat { get }
    var iconPadding: CGFloat { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var width: CGFloat { get }
    var height: CGFloat { get }
}

struct IconButtonNormalComponentLayout: IconButtonComponentLayoutProtocol {
    var iconSize: CGFloat = 24
    var iconPadding: CGFloat = 16
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat { get { return height / 2 } }
    var height: CGFloat { get { return iconSize + 2 * (iconPadding + borderWidth) } }
    var width: CGFloat { get { return height } }
}

struct IconButtonSmallComponentLayout: IconButtonComponentLayoutProtocol {
    var iconSize: CGFloat = 16
    var iconPadding: CGFloat = 8
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat { get { return height / 2.0 } }
    var height: CGFloat { get { return iconSize + 2 * (iconPadding + borderWidth) } }
    var width: CGFloat { get { return height } }
}
