
import Foundation

struct RowLabelsConstants {
    
    typealias V = StackedRowLabels.`Type`.Visibility
    
    struct Font {
        static let styles = StackedRowLabels.FontStyles(
            forTitle: Brandbook.Font.caption1,
            forBody: Brandbook.Font.body1,
            forDescription: Brandbook.Font.caption1)
    }
    
    struct Visibility {
        static let forOneLine: V = (isTitleHidden: true, isBodyHidden: false, isDescriptionHidden: true)
        static let forTwoLine: V = (isTitleHidden: false, isBodyHidden: false, isDescriptionHidden: true)
        static let forTwoLineReverse: V = (isTitleHidden: true, isBodyHidden: false, isDescriptionHidden: false)
        static let forThreeLines: V = (isTitleHidden: false, isBodyHidden: false, isDescriptionHidden: false)
    }
}
