
import UIKit

//public func color(
//    _ base: Base,
//    _ opacity: Opacity,
//    _ shade: Shade) -> UIColor {
//
//    ColorBook.shared.theme.color(
//        for: base,
//        opacity: opacity,
//        shade: shade)!
//}
//
//public func color(
//    _ background: Background) -> UIColor {
//    ColorBook.shared.theme.color(
//        for: background)!
//}
//
//public func color(
//    _ shade: Shade) -> UIColor {
//    ColorBook.shared.theme.color(
//        with: shade)!
//}
//
//public func color(
//    _ support: Support,
//    _ shade: Shade) -> UIColor {
//    ColorBook.shared.theme.color(
//        for: support,
//        shade: shade)!
//}
//
//public func color(
//    _ brand: Brand,
//    _ shade: Shade) -> UIColor {
//
//    ColorBook.shared.theme.color(for: brand, shade: shade)!
//}

public func string(
    fromDate: Date,
    toDate: Date,
    format: String = "dd.MM.yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return String(
        format: "%@ - %@",
        dateFormatter.string(from: fromDate),
        dateFormatter.string(from: toDate)
    )
}

func edgeInsetsWithEqual(with value: CGFloat) -> UIEdgeInsets {
    UIEdgeInsets.init(top: value, left: value, bottom: value, right: value)
}
