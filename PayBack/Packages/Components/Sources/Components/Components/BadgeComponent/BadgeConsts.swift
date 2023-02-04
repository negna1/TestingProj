

import UIKit

public protocol Dimension {
    var size: CGSize { get }
    var cornerRadius: CGFloat { get }
}

struct BadgeConsts {
    
    struct Size {
        static let small = CGSize(width: 12, height: 12)
        static let standard = CGSize(width: 18, height: 18)
        static let large = CGSize(width: 26, height: 18)
        static let iconSize =  CGSize(width: 10, height: 10)
        static let borderWidth: CGFloat = 1
        static let items: [Dimension] = [SmallBadge(), StandartBadge(), LargeBadge()]
    }
    
    struct Numbers {
        static let maxBadgeNumber = 99
        static let largeBadgeNumber = 9
    }
    
    struct Radius {
        static let small: CGFloat = 6
        static let standard: CGFloat = 9
        static let large: CGFloat = 8
    }
    
    struct Color {
        static var textColor: UIColor? { UIColor.green }
        static var border: UIColor? { UIColor.green }
    }
    
    struct Font {
        static let title = Brandbook.Font.caption2
    }
    
    struct Strings {
        static let maxNumberText = "99+"
    }
}

struct LargeBadge: Dimension {
    var size: CGSize { BadgeConsts.Size.large }
    var cornerRadius: CGFloat { BadgeConsts.Radius.large }
}

struct StandartBadge: Dimension {
    var size: CGSize { BadgeConsts.Size.standard }
    var cornerRadius: CGFloat { BadgeConsts.Radius.standard }
}

struct SmallBadge: Dimension {
    var size: CGSize { BadgeConsts.Size.small }
    var cornerRadius: CGFloat { BadgeConsts.Radius.small }
}
