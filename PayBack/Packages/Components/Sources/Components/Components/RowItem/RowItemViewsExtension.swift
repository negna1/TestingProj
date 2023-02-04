
import UIKit

public extension RowItem.Element {
    
    var view: UIView {
        switch self {
        case .imageWithUrl(let model):
            let wrapperView = ElementWrapper<RowImageView>(
                subview: RowImageView.init(type: .roundedImage))
            wrapperView.instance.sd_setImage(with: model.imageUrl, completed: nil)
            wrapperView.id = model.restorationId ?? self.restorationId
            wrapperView.onTap { model.onTap?(model) }
            return wrapperView
        case .image(let model, let type):
            let wrapperView = ElementWrapper<RowImageView>(
                subview: RowImageView.init(type: type))
            wrapperView.instance.image = model.image
            wrapperView.instance.tintColor = model.tint
            wrapperView.id = model.restorationId ?? self.restorationId
            wrapperView.onTap { model.onTap?(model) }
            return wrapperView
        case .badge(let model):
            let wrapperView = ElementWrapper<Badge>(
                subview: Badge())
            wrapperView.instance.configure(with: model)
            wrapperView.id = self.restorationId
            return wrapperView
        case .radioButton(let model):
            let radioButton = RadioButton()
            radioButton.configure(with: model)
            radioButton.id = self.restorationId
            return radioButton
        case .amount(let model):
            let amountLabel = RowItem.AmountLabel()
            amountLabel.configure(model: model)
            amountLabel.id = self.restorationId
            return amountLabel
        case .ovalIcon(let model):
            let wrapperView = ElementWrapper<ThumbnailOvalicon>.init(
                subview: ThumbnailOvalicon())
            wrapperView.instance.configure(with: model)
            wrapperView.id = self.restorationId
            return wrapperView
        case .tappableOvalIcon(let model):
            let wrapperView = ElementWrapper<ThumbnailOvalicon>.init(
                subview: ThumbnailOvalicon())
            wrapperView.instance.configure(with: model.ovalIconModel)
            wrapperView.instance.isUserInteractionEnabled = false
            wrapperView.id = model.restorationId ?? self.restorationId
            wrapperView.onTap { model.onTap?(model) }
            return wrapperView
        case .plusAmount(let model):
            let plusAmount = RowPlusAmount()
            plusAmount.configure(model: model)
            plusAmount.id = self.restorationId
            return plusAmount
        case .checkbox(let type, let delegate, let tag):
            let checkbox = CheckBox()
            checkbox.id = self.restorationId
            checkbox.configure(type: type)
            checkbox.tag = tag
            checkbox.delegate = delegate
            return checkbox
        case .shares(let model):
            let shares = RowSharesView()
            shares.id = self.restorationId
            shares.configure(with: model)
            return shares
        case .sharesOperation(let model):
            let shares = RowSharesView()
            shares.id = self.restorationId
            shares.configure(with: model)
            return shares
        case .smallButton(let model):
            let button = SmallButton()
            button.isEnabled = model.isEnabled
            button.action(handler: model.action)
            button.id = self.restorationId
            button.configure(model: model.buttonViewModel)
            return button
        }
    }
}

public extension RowItem.Element {
    
    var restorationId: String {
        switch self {
        case .image(let model, _):
            return model.restorationId ?? "image"
        case .imageWithUrl(let model):
            return model.restorationId ?? "imageWithUrl"
        case .badge:
            return "badge"
        case .radioButton:
            return "radioButton"
        case .amount:
            return "AmountLabel"
        case .ovalIcon:
            return "OvalIcon"
        case .tappableOvalIcon:
            return "TappableOvalIcon"
        case .plusAmount:
            return "PlusAmount"
        case .checkbox:
            return "Checkbox"
        case .shares, .sharesOperation:
            return "Shares"
        case .smallButton:
            return "SmallButton"
        }
    }
}
