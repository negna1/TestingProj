
import Foundation
import UIKit
protocol FunctionButtonComponentLayoutProtocol {

    var minWidth: CGFloat { get }
    var maxWidth: CGFloat { get }

    var cornerRadius: CornerRadius { get }
    
    var contentLeading: CGFloat { get }
    var contentTrailing: CGFloat { get }
    var contentTop: CGFloat { get }
    var contentBottom: CGFloat { get }

    var iconWidth: CGFloat { get }
    var iconHeight: CGFloat { get }
    var spacing: CGFloat { get }

    var font: UIFont { get }
}

struct FunctionButtonComponentLayout: FunctionButtonComponentLayoutProtocol {

    var minWidth: CGFloat = 48
    var maxWidth: CGFloat = 135

    var cornerRadius: CornerRadius = .Fifty

    var contentLeading: CGFloat = 24
    var contentTrailing: CGFloat = 24
    var contentTop: CGFloat = 17
    var contentBottom: CGFloat = 16

    var iconWidth: CGFloat = 16
    var iconHeight: CGFloat = 15
    var spacing: CGFloat = 2

    var font: UIFont = Brandbook.Font.caption2
}
