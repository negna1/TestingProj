

import UIKit

extension OvalActionButton {
    
    public enum ImageType {
        
        typealias Demensions = OvalActionButton.Constants.Demensions
        typealias Colors = OvalActionButton.Constants.Colors
        
        case icon, thumbnail
        
        var renderingMode: UIImage.RenderingMode {
            switch self {
            case .icon:
                return .alwaysTemplate
            case .thumbnail:
                return .alwaysOriginal
            }
        }
        
        var tintColor: UIColor? {
            switch self {
            case .icon:
                return Colors.icon
            case .thumbnail:
                return nil
            }
        }
        
        var placeholderImage: UIImage? {
            switch self {
            case .icon:
                return nil
            case .thumbnail:
                return UIImage(placeholderImageType: .circle)
            }
        }
        
        var imagePadding: CGFloat {
            switch self {
            case .icon:
                return Demensions.Image.iconPadding
            case .thumbnail:
                return Demensions.Image.thumbnailPadding
            }
        }
    }
}
