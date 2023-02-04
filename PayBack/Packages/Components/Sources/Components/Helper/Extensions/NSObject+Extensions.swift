
import Foundation

extension NSObject {
    ///Returns the name of a class as a string.
    static var stringFromClass: String { NSStringFromClass(self) }
    ///Returns only the name of Swfit class
    static var className: String { stringFromClass.components(separatedBy: ".").last! }
}
