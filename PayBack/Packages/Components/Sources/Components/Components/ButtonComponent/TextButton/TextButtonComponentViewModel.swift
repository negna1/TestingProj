

import UIKit

public struct TextButtonComponentViewModel {
    let title: String
    let type: TextButtonType
    let icon: UIImage?
    
    public static func large(title: String)  -> TextButtonComponentViewModel {
        return TextButtonComponentViewModel(title: title,
                                            type: .large,
                                            icon: nil)
    }
    
    public static func small(title: String)  -> TextButtonComponentViewModel {
        return TextButtonComponentViewModel(title: title,
                                            type: .small,
                                            icon: nil)
    }
    
    public static func smallIconText(icon: UIImage, title: String)  -> TextButtonComponentViewModel {
        return TextButtonComponentViewModel(title: title,
                                            type: .smallIconText,
                                            icon: icon)
    }
}
