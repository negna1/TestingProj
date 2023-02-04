//
//  TransactionDetailsModel.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import Components
import UIKit

extension TransactionDetailsController.CellModelType {
    
    var tableCellModel: TableCellModel {
        switch self {
        case .title(let title, let description):
            let titlestyle = UILabel.Style.predefined(title)
            let descrstyle = UILabel.Style.predefined(description)
            let labels = StackedRowLabels.ViewModel.init(type: .twoLine(titleStyle: titlestyle,
                                                                        bodyStyle: descrstyle))
            
            let model = RowItem.ViewModel.init(labels: labels)
            return RowTableCell.CellModel(borderModel: model)
        }
    }
}
 
extension TransactionDetailsController {
    enum Section: CaseIterable {
        case initial
    }
    
    enum CellModelType: Hashable {
        case title(String, String)
    }
}

extension TransactionDetailsController.CellModelType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tableCellModel.id == rhs.tableCellModel.id
    }
}

