
import UIKit

// MARK: - RowItemModels
public extension RowItem {
    
    struct ViewModel: Hashable {
        public static func == (lhs: RowItem.ViewModel, rhs: RowItem.ViewModel) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
         }
        
        let labels: StackedRowLabels.ViewModel
        let leftElements: RowItem.Elements?
        let rightElements: RowItem.Elements?
        let needSeparator: Bool
        var id: UUID = UUID()
        public init(
            labels: StackedRowLabels.ViewModel,
            leftElements: RowItem.Elements? = nil,
            rightElements: RowItem.Elements? = nil,
            needSeparator: Bool = false) {
            
            self.labels = labels
            self.leftElements = leftElements
            self.rightElements = rightElements
            self.needSeparator = needSeparator
        }
    }
}

public extension RowItem {
    
    enum Element {
        case image(TappableRowItemImage, RowImageView.`Type` = .icon24x24)
        case imageWithUrl(TappableRowItemRemoteImage)
        case badge(BadgeModel)
        case radioButton(RadioButton.ViewModel)
        case amount(CcyAmount)
        case ovalIcon(ThumbnailOvalicon.ViewModel)
        case tappableOvalIcon(TappableOvalIcon)
        case plusAmount(RowPlusAmount.ViewModel)
        case checkbox(CheckBox.ModelType, CheckBoxDelegate?, Int = 0)
        case shares(RowSharesView.ViewModel)
        case sharesOperation(RowSharesView.OperationViewModel)
        case smallButton(SmallButtonRowViewModel)
    }
}

public extension RowItem {
    
    enum Elements {
        case single(RowItem.Element)
        case double(RowItem.Element, RowItem.Element)
    }
}

public struct SmallButtonRowViewModel {
    
    public typealias Action = () -> ()
    
    var buttonViewModel: SmallButtonViewModel
    var action: Action?
    var isEnabled: Bool
    
    public init(buttonViewModel: SmallButtonViewModel,
                action: Action?,
                isEnabled: Bool = true) {
        
        self.buttonViewModel = buttonViewModel
        self.action = action
        self.isEnabled = isEnabled
    }
}
