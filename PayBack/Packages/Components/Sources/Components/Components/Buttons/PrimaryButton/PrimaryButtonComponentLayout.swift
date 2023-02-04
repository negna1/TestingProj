

// FIXME: import only UIKit
import Foundation
import UIKit

/* FIXME: Could be generic
 * Other UI components also have these parameters.
 * Use something more generic protocol which will be used
 * in other components too. Why create such protocol for every single
 * component?
 */
protocol PrimaryButtonComponentLayoutProtocol {
    var cornerRadius: CGFloat { get }
    var borderWidth: CGFloat { get }
    var padding: CGFloat { get }
    
    func font(for type: PrimaryButtonComponent.ButtonType) -> UIFont
    func height(type: PrimaryButtonComponent.ButtonType) -> CGFloat
}

struct PrimaryButtonComponentLayout: PrimaryButtonComponentLayoutProtocol {
    let cornerRadius: CGFloat = 16
    let borderWidth: CGFloat = 0
    let padding: CGFloat = 27
    
    func font(for type: PrimaryButtonComponent.ButtonType) -> UIFont {
        switch type {
        case .standard: return Brandbook.Font.button1
        case .small: return Brandbook.Font.button2
        }
    }
    
    func height(type: PrimaryButtonComponent.ButtonType) -> CGFloat {
        switch type {
        case .standard: return 56
        case .small: return 40
        }
    }
}
