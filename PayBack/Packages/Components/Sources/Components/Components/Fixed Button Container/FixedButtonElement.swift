

import UIKit

public extension FixedButtonContainer {
 
    enum TopElement {
        case commission(Double, Currency)
        case chips(ChipsViewModel)
        case titledChipsView(TitledChipsViewModel)
        case infoLabel(String)
        case checkbox(CheckBox.ModelType, CheckBoxDelegate?)
    }
    
    enum LeftElement {
        case ovalIcon(SmallOvalIconModel)
        case deleteButton(tapped: () -> Void)
    }
    
    enum BottomElement {
        case commission(Double, Currency)
    }
}

public extension FixedButtonContainer.TopElement {
    
    var view: UIView {
        switch self {
        case .commission(let amount, let currency):
            return CommissionLabel.init(amount: amount, ccy: currency)
        case .chips(let model):
            return ChipsView.init(model: model)
        case .titledChipsView(let model):
            return TitledChipsView(model: model)
        case .infoLabel(let title):
            return InfoLabel(with: title)
        case .checkbox(_, _):
            return UIView()
                //FIXME: right checkbox
//            return checkbox(
//                withType: type,
//                andDelegate: delegate)
        }
    }
    
//    private func checkbox(
//        withType type: CheckBox.ModelType,
//        andDelegate delegate: CheckBoxDelegate?) -> CheckBoxWrapper {
//
//        let checkbox = CheckBoxWrapper()
//        checkbox.configure(withCheckbox: type)
//        checkbox.set(delegate: delegate)
//        return checkbox
//    }
}

public extension FixedButtonContainer.LeftElement {
    
    var view: UIView {
        switch self {
        case .ovalIcon(let model):
            return SmallOvalIcon(model: model)
        case .deleteButton(_):
            return SmallOvalIcon.init()
           // return DeleteButton(tapped: callback)
        }
    }
}

public extension FixedButtonContainer.BottomElement {
    var view: UIView {
        switch self {
        case .commission(let amount, let currency):
            return CommissionLabel.init(amount: amount, ccy: currency)
        }
    }
}
