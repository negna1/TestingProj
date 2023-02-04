
import Foundation
import UIKit

protocol ChipsViewProtocol: AnyObject {
    func reloadData(from intexPath: IndexPath?)
    func reloadItem(at indexPath: IndexPath)
}

protocol ChipsViewPresenter {
    func numberOfItems() -> Int
    func cellId(at indexPath: IndexPath) -> String
    func configure(cell: ChipsViewCollectionCell, at indexPath: IndexPath)
    func didSelectItem(at indexPath: IndexPath)
    func sizeForCell(at indexPath: IndexPath) -> CGSize
}

public class ChipsViewPresenterImpl: ChipsViewPresenter {
    
    private weak var view: ChipsViewProtocol?
    private var dataSource: [ChipsCellViewModel] = []
    
    init(dataSource: [ChipsCellViewModel], view: ChipsViewProtocol) {
        self.view = view
        self.dataSource = dataSource
        self.view?.reloadData(from: nil)
    }
    
    func numberOfItems() -> Int {
        dataSource.count
    }
    
    func cellId(at indexPath: IndexPath) -> String {
        dataSource[indexPath.row].reuseId
    }
    
    func configure(cell: ChipsViewCollectionCell, at indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        cell.configure(viewModel: model)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let item = dataSource[indexPath.row]
        switch item.type {
        case .checkbox:
            handleDidSelect(item: item as! CheckboxChipsCellViewModel, at: indexPath)
        case .standard:
            handleDidSelect(item: item as! StandardChipsCellViewModel, at: indexPath)
        case .iconed:
            handleDidSelect(item: item as! IconedChipsCellViewModel, at: indexPath)
        }
    }
    
    private func handleDidSelect(item: StandardChipsCellViewModel, at indexPath: IndexPath) {
        if item.state != .disabled {
            if item.type == .standard {
                deselectPreviousCell()
                view?.reloadData(from: indexPath)
            }
            item.state = .active
        }
    }
    
    private func handleDidSelect(item: CheckboxChipsCellViewModel, at indexPath: IndexPath) {
        if item.state != .disabled {
            if item.state == .active {
                item.state = .enabled
            } else if item.state == .enabled {
                item.state = .active
            } else if item.state == .intermediate {
                item.state = .active
            }
            view?.reloadItem(at: indexPath)
        }
    }
    
    private func handleDidSelect(item: IconedChipsCellViewModel, at indexPath: IndexPath) {
        if item.state != .disabled {
            if item.type == .standard {
                deselectPreviousCell()
                view?.reloadData(from: indexPath)
            }
            item.state = .active
        }
    }
    

    func sizeForCell(at indexPath: IndexPath) -> CGSize {
        let item = dataSource[indexPath.row]
        let title = Localizer.shared.localizedValue(for: item.title)
        let checkBoxOffset = (item.type == .checkbox || item.type == .iconed) ? ChipsViewConstants.checkboxWidth : 0
        let dynamicWidth = CGFloat(integerLiteral: title.count) * ChipsViewConstants.charLength + ChipsViewConstants.cellPadding + checkBoxOffset
        return .init(width: dynamicWidth, height: ChipsViewConstants.cellHeight)
    }
}

// MARK: Internal Methods
extension ChipsViewPresenterImpl {
    private func deselectPreviousCell() {
        if dataSource.first!.type == .standard {
            if let chip = dataSource.first(where: {($0 as! StandardChipsCellViewModel).state == .active}) {
                (chip as! StandardChipsCellViewModel).state = .enabled
            }
        } else {
            if let chip = dataSource.first(where: {
                                            ($0 as! CheckboxChipsCellViewModel).state == .active ||
                                                ($0 as! CheckboxChipsCellViewModel).state == .intermediate }) {
                (chip as! CheckboxChipsCellViewModel).state = .enabled 
            }
        }
    }
}
