

import UIKit

public extension ThumbnailOvalicon {
    
    struct ViewModel {
        let type: `Type`
        let size: Size
        
        public init(
            type: `Type`,
            size: Size = .small) {
            self.type = type
            self.size = size
        }
    }
    
    enum `Type` {
        case thumbnail(Thumbnail)
        case ovalicon(Ovalicon)
    }
    
    struct Ovalicon {
        let image: UIImage
        let backgroundColor: UIColor
        let borderColor: UIColor
        let tintColor: UIColor
        
        public init(image: UIImage, backgroundColor: UIColor, borderColor: UIColor, tintColor: UIColor) {
            self.image = image
            self.backgroundColor = backgroundColor
            self.borderColor = borderColor
            self.tintColor = tintColor
            
        }
    }
    
    struct Thumbnail {
        let image: UIImage?
        let borderColor: UIColor
        
        public init(image: UIImage?, borderColor: UIColor) {
            self.image = image
            self.borderColor = borderColor
        }
    }
}

public extension ThumbnailOvalicon {
    
    enum Size {
        case small
        case large
    }
}

extension ThumbnailOvalicon.Size {
    
    var forImage: CGSize {
        switch self {
        case .small:
            return CGSize(width: 36, height: 36)
        case .large:
            return CGSize(width: 56, height: 56)
        }
    }
    
    var forIcon: CGSize {
        switch self {
        case .small:
            return CGSize(width: Spacing.M.floatValue, height: Spacing.M.floatValue)
        case .large:
            return CGSize(width: Spacing.XL.floatValue, height: Spacing.XL.floatValue)
        }
    }
}
