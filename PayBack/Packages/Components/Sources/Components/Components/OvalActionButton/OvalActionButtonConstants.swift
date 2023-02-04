
import UIKit

extension OvalActionButton {
    
    struct Constants {
        
        struct Colors {
            static let icon =  UIColor.orange
            static let border =  UIColor.orange
            static let closeIcon =  UIColor.orange
            static let closeBackground =  UIColor.orange
            static let title =  UIColor.orange
            static let amount =  UIColor.orange
        }
        
        struct Fonts {
            static let title = Brandbook.Font.caption1
            static let amount = Brandbook.Font.caption2
        }
        
        struct Demensions {
            static let width: CGFloat = 72
            
            struct CloseIconContainer {
                static let size: CGSize = CGSize(width: 16, height: 16)
                static let leftConstraint = -Spacing.S.floatValue
            }
            
            struct CloseIcon {
                static let padding: CGFloat = 3
            }
            
            struct ImageContainer {
                static let size: CGSize = CGSize(width: 44, height: 44)
                static let borderWidth: CGFloat = 1
            }
            
            struct Image {
                static let iconPadding: CGFloat = 10
                static let thumbnailPadding: CGFloat = 1
            }
            
            struct TitleLabel {
                static let numberOfLines = 1
                static let topConstraint = Spacing.XS2.floatValue
            }
            
            struct AmountLabel {
                static let topConstraint = Spacing.XS2.floatValue
            }
            
        }
        
        struct Images {
            static let closeIcon = UIImage(systemName: "x.circle.fill")
        }
    }
    
}
