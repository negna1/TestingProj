

// FIXME: import UIKit only
import Foundation
import UIKit

struct PrimaryButtonComponentViewModel: PrimaryButtonComponentViewModelProtocol {

    var layout: PrimaryButtonComponentLayoutProtocol = PrimaryButtonComponentLayout()

    /* FIXME: Replace Array with Dictionary
     * Dictionary mapping ButtonState to UIColor ([ButtonState: UIColor])
     * would be more readable
     */
    private let backgroundColors: [UIColor?] = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange,
    ]

    // FIXME: Replace Array with Dictionary ([ButtonState: UIColor])
    private let titleColors: [UIColor?] = [
        UIColor.orange,
        UIColor.orange,
        UIColor.orange,
    ]

    
    /* FIXME: Better function argument naming
              Current: backgroundColor(forState state: ButtonState)
              Better: backgroundColor(for state: ButtonState) */
    func backgroundColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }

    /* FIXME: Better function argument naming
              Current: titleColor(forState state: ButtonState)
              Better: titleColor(for state: ButtonState) */
    func titleColor(forState state: ButtonState) -> UIColor? {
        return titleColors[state.rawValue]
    }

    /* FIXME: Better function argument naming
              Current: borderColor(forState state: ButtonState)
              Better: borderColor(for state: ButtonState) */
    func borderColor(forState state: ButtonState) -> UIColor? {
        return backgroundColors[state.rawValue]
    }
}
