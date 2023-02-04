

import UIKit

enum SecondaryButtonType {
    case solidTextIconBadge
    case solidTextBadge
    case dashTextIconBadge
    case dashTextBadge
    
    case solidTextIcon
    case solidText
    case dashTextIcon
    case dashText
    
    func stateModel(for state: ComplexButton.State) -> IconBadgeButtonContentViewStateModel {
        switch self {
        case .solidTextIconBadge:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
        case .solidTextBadge:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
        case .dashTextIconBadge:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
        case .dashTextBadge:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
            
        case .solidTextIcon:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha:  ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
            
        case .solidText:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
        case .dashTextIcon:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
        case .dashText:
            switch state {
            case .enabled:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .pressed:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaEnabled)
            case .disable:
                let contentColor = UIColor.green
                return IconBadgeButtonContentViewStateModel( textColor: contentColor,
                                                             badgeAlpha: ButtonConstant.BadgeAlphaDisabled)
            }
        }
    }
    
    func backgroundColor(for state: ComplexButton.State) -> UIColor {
        switch self {
        case .solidTextIconBadge:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .solidTextBadge:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .dashTextIconBadge:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .dashTextBadge:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .solidTextIcon:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
            
        case .solidText:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .dashTextIcon:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .dashText:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        }
    }
    
    func borderColor(for state: ComplexButton.State) -> UIColor {
        switch self {
        case .solidTextIconBadge:
            switch state {
            case .enabled:
                return .clear
            case .pressed:
                return .clear
            case .disable:
                return .clear
            }
        case .solidTextBadge:
            switch state {
            case .enabled:
                return .clear
            case .pressed:
                return .clear
            case .disable:
                return .clear
            }
        case .dashTextIconBadge:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .dashTextBadge:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .solidTextIcon:
            switch state {
            case .enabled:
                return .clear
            case .pressed:
                return .clear
            case .disable:
                return .clear
            }
            
        case .solidText:
            switch state {
            case .enabled:
                return .clear
            case .pressed:
                return .clear
            case .disable:
                return .clear
            }
        case .dashTextIcon:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .dashText:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .solidTextIconBadge:
            return .zero
        case .solidTextBadge:
            return .zero
        case .dashTextIconBadge:
            return CGFloat(ButtonConstant.Secondary.DashTextIconBadge.borderWidth)
        case .dashTextBadge:
            return CGFloat(ButtonConstant.Secondary.DashTextBadge.borderWidth)
        case .solidTextIcon:
            return CGFloat(ButtonConstant.Secondary.Loadable.SolidTextIcon.borderWidth)
        case .solidText:
            return CGFloat(ButtonConstant.Secondary.Loadable.SolidText.borderWidth)
        case .dashTextIcon:
            return CGFloat(ButtonConstant.Secondary.Loadable.DashTextIcon.borderWidth)
        case .dashText:
            return CGFloat(ButtonConstant.Secondary.Loadable.DashText.borderWidth)
        }
    }
    
    var borderStyle: ComplexButton.BorderStyle {
        switch self {
        case .solidTextIconBadge, .solidTextBadge, .solidTextIcon, .solidText:
            return .solid
        case .dashTextIconBadge, .dashTextBadge, .dashTextIcon, .dashText:
            return .dash


        }
    }
    
    var loadingImage: UIImage? {
        switch self {
        case .solidTextIconBadge, .solidTextBadge, .dashTextIconBadge, .dashTextBadge:
            return nil
        case .solidTextIcon, .solidText, .dashTextIcon, .dashText:
            return UIImage(systemName: "hand.thumbsup.fill")
        }
    }
}
