

import UIKit

public class CacheStackView: UIStackView {

    typealias WrappedImageView = ElementWrapper<RowImageView>
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = Spacing.M.floatValue
    }
    
    public func configure(
        subviews: [RowItem.Element]) {
        
        let idsToShow = subviews
            .map { $0.restorationId }
            .compactMap { $0 }
        
        arrangedSubviews.forEach {
            $0.isHidden = !idsToShow.contains($0.id!)
        }
        
        subviews.forEach { configureOrInsert(element: $0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -Subviews Logics

extension CacheStackView {
    
    private func configureOrInsert(element: RowItem.Element) {
        
        switch element {
        case .image(let model, _):
            guard let view = viewInStack(with: element.restorationId)
                    as? WrappedImageView else {
                return append(view: element.view)
            }
            view.onTap { model.onTap?(model) }
            view.instance.image = model.image
        case .imageWithUrl(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? WrappedImageView else {
                return append(view: element.view)
            }
            
            view.instance.sd_setImage(with: model.imageUrl, completed: nil)
        case .badge(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? ElementWrapper<Badge> else {
                return append(view: element.view)
            }
            
            view.instance.configure(with: model)
            
        case .radioButton(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? RadioButton else {
                return append(view: element.view)
            }
            
            view.configure(with: model)
        case .amount(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? RowItem.AmountLabel else {
                return append(view: element.view)
            }
            
            view.configure(model: model)
        case .ovalIcon(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? ElementWrapper<ThumbnailOvalicon> else {
                return append(view: element.view)
            }
            
            view.instance.configure(with: model)
        case .tappableOvalIcon(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? ElementWrapper<ThumbnailOvalicon> else {
                return append(view: element.view)
            }
            
            view.instance.configure(with: model.ovalIconModel)
        case .plusAmount(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? RowPlusAmount else {
                return append(view: element.view)
            }
            
            view.configure(model: model)
        case .checkbox(let type, let delegate, let tag):
            guard let view = viewInStack(with: element.restorationId)
                    as? CheckBox else {
                return append(view: element.view)
            }
            
            view.delegate = delegate
            view.tag = tag
            view.configure(type: type)
        case .shares(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? RowSharesView else {
                return append(view: element.view)
            }
            
            view.configure(with: model)
        case .sharesOperation(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? RowSharesView else {
                return append(view: element.view)
            }
            
            view.configure(with: model)
        case .smallButton(let model):
            guard let view = viewInStack(with: element.restorationId)
                    as? SmallButton else {
                return append(view: element.view)
            }
            
            view.configure(model: model.buttonViewModel)
            view.action(handler: model.action)
            view.isEnabled = model.isEnabled
        }
    }
    
    private func viewInStack(with id: String) -> UIView? {
        return arrangedSubviews.first(where: { $0.id == id })
    }
    
    private func append(view: UIView) {
        addArrangedSubview(view)
    }
}

