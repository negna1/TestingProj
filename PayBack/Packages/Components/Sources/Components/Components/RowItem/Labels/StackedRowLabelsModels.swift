
import UIKit

public extension StackedRowLabels {
    
    enum `Type` {
        case oneLine(bodyStyle: UILabel.Style)
        case twoLine(titleStyle: UILabel.Style, bodyStyle: UILabel.Style)
        case twoLineReverse(titleStyle: UILabel.Style, bodyStyle: UILabel.Style)
        case threeLine(titleStyle: UILabel.Style, bodyStyle: UILabel.Style, descriptionStyle: UILabel.Style)
    }
    
    struct FontStyles {
        let forTitle: UIFont
        let forBody: UIFont
        let forDescription: UIFont
    }
    
    struct ViewModel {
        var type: StackedRowLabels.`Type`
        var isEnabled: Bool = true
        
        public init(
            type: StackedRowLabels.`Type`,
            isEnabled: Bool = true) {
            self.type = type
            self.isEnabled = isEnabled
        }
    }
}

extension StackedRowLabels.`Type` {
    
    typealias Visibility = (isTitleHidden: Bool, isBodyHidden: Bool, isDescriptionHidden: Bool)
    typealias C = RowLabelsConstants.Visibility
    
    var visibility: Visibility {
        switch self {
        case .oneLine:
            return C.forOneLine
        case .twoLine:
            return C.forTwoLine
        case .twoLineReverse:
            return C.forTwoLineReverse
        case .threeLine:
            return C.forThreeLines
        }
    }
}

extension StackedRowLabels.ViewModel {
    
    typealias Colors = (title: UIColor, body: UIColor, descr: UIColor)
    
    var colors: Colors {
        switch self.isEnabled {
        case true:
            return (
                title: UIColor.black,
                body: UIColor.gray,
                descr: UIColor.darkGray
            )
        default:
            return (
                title: UIColor.black,
                body: UIColor.gray,
                descr: UIColor.darkGray
            )
        }
    }
}
