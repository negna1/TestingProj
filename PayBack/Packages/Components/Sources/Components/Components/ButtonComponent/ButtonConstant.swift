

import Foundation


struct ButtonConstant {
    
    // MARK: Button Common constants
    static let BadgeAlphaEnabled = 1.0
    static let BadgeAlphaDisabled = 0.48
    
    static let rotatingLoadingAnimationDuration: Double = 2
    static let rotatingLoaderRotation: Double = Double.pi * 2.0
    
    // MARK:  Primary Button constants
    struct Primary {
        static let leftRightOffset = 24.0
        static let loaderOffset = 16
        
        static let loadingAnimationKey = "spin"
        static let loadingAnimationKeyPath = "transform.rotation"
        
        struct Large {
            static let height = 56.0
            static let cornerRadius = 16.0
            static let loaderSize = 20.0
        }
        struct Small {
            static let height = 40.0
            static let cornerRadius = 12.0
            static let loaderSize = 14.0
        }
    }
    
    // MARK:  Small Button constants
    struct Small {
        static let buttonHeight = 32.0
        static let cornerRadius = 16.0
        
        struct Border {
            static let minWidth = 94.0
            static let contenntHorizontalOffsetMin = 16.0
        }
        
        struct Text {
            static let minWidth = 108.0
            static let contenntHorizontalOffsetMin = 14.0
        }
        
        struct TextIcon {
            static let minWidth = 108.0
            static let iconDistance = 8.0
            static let contenntHorizontalOffsetMin = 14.0
        }
        
        struct IconText {
            static let minWidth = 73.0
            static let iconDistance = 4.0
            static let iconSize = 16.0
            static let contenntHorizontalOffsetMin = 16.0
        }
        
        struct IconTextWhite {
            static let minWidth = 100.0
            static let iconDistance = 8.0
            static let contenntHorizontalOffsetMin = 12.0
        }
        struct TextIconBadge {
            static let minWidth = 124.0
            static let iconDistance = 8.0
            static let badgeDistance = 11.0
            static let contenntHorizontalOffsetMin = 12.0
        }
    }
    
    // MARK:  Small Button constants
    struct Secondary {
        static let buttonHeight = 40.0
        static let cornerRadius = 12.0
        static let iconDistance = Spacing.M.rawValue
        static let badgeDistance = Spacing.XS.rawValue
        static let contenntHorizontalOffsetMin = Spacing.XL.rawValue
        
        static let loadingAnimationKey = "spin"
        static let loadingAnimationKeyPath = "transform.rotation"
        
        struct DashTextIconBadge {
            static let borderWidth = 1.0
        }
        
        struct DashTextBadge {
            static let borderWidth = 1.0
        }
        
        struct Loadable {
            static let loadingViewOffset = 16.0
            
            struct SolidTextIcon {
                static let borderWidth = 0.0
            }
            
            struct SolidText {
                static let borderWidth = 0.0
            }
            
            struct DashTextIcon {
                static let borderWidth = 1.0
            }
            
            struct DashText {
                static let borderWidth = 1.0
            }
        }
    }
    
    struct Text {
        static let buttonHeight = 23.0
        struct SmallIconText {
            static let iconDistance = 6.0
        }
    }
    
    struct Action {
        static let imageContainerBorderWidth = 1.0
        static let imageTextAmountElementsSpace = 4.0
        static let numberOfLines = 3
        
        struct Transfer {
            static let width = 80
            static let height = 104
            static let iconContainerSize = 56.0
            static let iconContainerCornerRadius = 24.0
        }
        
        struct Card {
            static let width = 80
            static let height = 76
            static let iconContainerSize = 40.0
            static let iconContainerCornerRadius = 20.0
        }
    }
    
}
