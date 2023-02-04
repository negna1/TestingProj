

import UIKit

struct TextBadgeConsts {
    struct Padding {
        static let topInset: CGFloat = 9.0
        static let bottomInset: CGFloat = { topInset }()
        static let upercaseLeftRight: CGFloat = 6
        static let captionMinWidth: CGFloat = 213
        static let captionSpacing: CGFloat = 3
    }
    
    struct Font {
        static let singleText = Brandbook.Font.subtitle2
        static let doubleText = Brandbook.Font.caption1
        static let description = Brandbook.Font.caption2
        static let upercase = Brandbook.Font.button2
        static let caption = {doubleText}()
        static let captionTitle = Brandbook.Font.subtitle2
        static let doubleWithCaptionTitle = Brandbook.Font.caption2
    }
}
