

// FIXME: UIKit consists of Foundation, so no need to import it
import Foundation
import UIKit

/* FIXME: Bad Naming.
 * Protocol names don't need 'Protocol' suffix in the end.
 * Just try more descriptive and generic names.
 * 'TitleSettable' or something like this would be better here
 */
public protocol PrimaryButtonProtocol {
    func setContentTitle(title: String)
}

/* FIXME: Bad Naming
* No need to add 'Protocol' suffix in the name
*/
protocol PrimaryButtonComponentViewModelProtocol: ButtonComponentViewModelProtocol {
    var layout: PrimaryButtonComponentLayoutProtocol { get }
    func borderColor(forState state: ButtonState) -> UIColor?
}
