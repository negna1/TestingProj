

import UIKit

public struct BadgeModel {
    
    private (set) var style: Style
    private (set) var attributedTitle = NSAttributedString()
    private (set) var dimension: Dimension!
    
    public init(_ badgeStyle: BadgeModel.Style,
                _ icon: UIImage) {
        style = badgeStyle
        attributedTitle = attributedTitle(with: icon)
        dimension = dimension(dependingOn: attributedTitle)
    }
    
    public init(_ badgeStyle: BadgeModel.Style) {
        style = badgeStyle
        dimension = dimension(dependingOn: attributedTitle)
    }
    
    public init(_ badgeStyle: BadgeModel.Style,
                _ number: UInt) {
        style = badgeStyle
        attributedTitle = attributedTitle(with: stringAssociated(to: number))
        dimension = dimension(dependingOn: attributedTitle)
    }
    
    private init(_ badgeStyle: BadgeModel.Style,
                  plus items: UInt) {
        style = badgeStyle
        attributedTitle = attributedTitle(with: "\(items)+")
        dimension = dimension(dependingOn: attributedTitle)
    }
    
    public init(_ type: BadgeModel.`Type`) {
        switch type {
        case .empty(let style):
            self.init(style)
        case .icon(let style, let icon):
            self.init(style, icon)
        case .number(let style, let count):
            self.init(style, count)
        case .plus(let style, let count):
            self.init(style, plus: count)
        }
    }
    
    private func stringAssociated(to badgeNumber: UInt) -> String {
        guard badgeNumber != .zero else {
            fatalError("badgeNumber must not be zero")
        }
        return badgeNumber > BadgeConsts.Numbers.maxBadgeNumber
        ? "\(BadgeConsts.Strings.maxNumberText)"
        : "\(badgeNumber)"
    }
    
    private func dimension(dependingOn title: NSAttributedString) -> Dimension {
        BadgeConsts.Size.items.count >= title.length ? LargeBadge() :
        BadgeConsts.Size.items[title.length]
    }
    
    private func attributedTitle(with icon: UIImage) -> NSAttributedString {
        let builder = AttributedStringBuilder()
            builder.image(icon.withRenderingMode(.alwaysTemplate), size: BadgeConsts.Size.iconSize)
        return builder.attributedString
    }
    
    private func attributedTitle(with text: String) -> NSAttributedString {
        let builder = AttributedStringBuilder()
            builder.text(text)
        return builder.attributedString
    }
}

extension BadgeModel {
    public enum Style {
        case notifications
        case info
        case active
        
        var backgroundColor: UIColor {
            switch self {
            case .notifications:
                return UIColor.green
            case .info:
                return UIColor.green
            case .active:
                return UIColor.green
            }
        }
    }
}

extension BadgeModel {
    public enum `Type` {
        case empty(style: BadgeModel.Style)
        case icon(style: BadgeModel.Style, icon: UIImage)
        case number(style: BadgeModel.Style, count: UInt)
        case plus(style: BadgeModel.Style, count: UInt)
    }
}

