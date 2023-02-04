
import UIKit

enum SmallButtonType {
    case border
    case text
    case textIcon(titleAndIconTint: UIColor? = nil, backgroundTint: UIColor? = nil)
    case iconText
    case iconTextWhite
    case textIconBadge
    
    var minWidth: CGFloat {
        switch self {
        case .border:
            return CGFloat(ButtonConstant.Small.Border.minWidth)
        case .text:
            return CGFloat(ButtonConstant.Small.Text.minWidth)
        case .textIcon:
            return CGFloat(ButtonConstant.Small.TextIcon.minWidth)
        case .iconText:
            return CGFloat(ButtonConstant.Small.IconText.minWidth)
        case .iconTextWhite:
            return CGFloat(ButtonConstant.Small.IconTextWhite.minWidth)
        case .textIconBadge:
            return CGFloat(ButtonConstant.Small.TextIconBadge.minWidth)
        }
    }
    
    func stateModel(for state: ComplexButton.State) -> IconBadgeButtonContentViewStateModel {
        switch self {
        case .border:
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
        case .text:
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
        case .textIcon(let titleAndIconTint, _):
            switch state {
            case .enabled:
                let contentColor = titleAndIconTint ?? UIColor.green
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
        case .iconText:
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
        case .iconTextWhite:
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
        case .textIconBadge:
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
        case .border:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .text:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .textIcon(_, let backgroundTint):
            switch state {
            case .enabled:
                return backgroundTint ?? UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .iconText:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .iconTextWhite:
            switch state {
            case .enabled:
                return UIColor.green
            case .pressed:
                return UIColor.green
            case .disable:
                return UIColor.green
            }
        case .textIconBadge:
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
}
