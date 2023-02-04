//
//  TransactionModels.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 01.02.23.
//

import Components
import UIKit

extension TransactionsController.CellModelType {
    
    var tableCellModel: TableCellModel {
        switch self {
        case .wholeTransaction(let amount, let currency):
            let leftElementRowItem = RowItem.Element.image(.init(id: UUID().uuidString,
                                                                 onTap: nil,
                                                                 image: UIImage(named: "ic_shop") ?? UIImage()))
            let leftElement = RowItem.Elements.single(leftElementRowItem)
            let rightElement = RowItem.Elements.single(.amount(.init(amount: amount, ccy: Currency.init(rawValue: currency) ?? .eur )))
            
            let titlestyle = UILabel.Style.predefined("whole transaction")
            let labels = StackedRowLabels.ViewModel.init(type: .oneLine(bodyStyle: titlestyle))
            
            let model = RowItem.ViewModel.init(labels: labels,
                                               leftElements: leftElement,
                                               rightElements: rightElement)
            return RowTableCell.CellModel(borderModel: model)
        case .title(let title, let description, let icon, let amount, let currency):
            let leftElementRowItem = RowItem.Element.image(.init(id: UUID().uuidString,
                                                                 onTap: nil,
                                                                 image: icon))
            let leftElement = RowItem.Elements.single(leftElementRowItem)
            let rightElementRowItem = RowItem.Element.image(.init(id: UUID().uuidString,
                                                                 onTap: nil,
                                                                 image: icon))
            let rightElement = RowItem.Elements.single(.amount(.init(amount: amount, ccy: Currency.init(rawValue: currency) ?? .eur )))
            
            let titlestyle = UILabel.Style.predefined(title)
            let descrstyle = UILabel.Style.predefined(description)
            let labels = StackedRowLabels.ViewModel.init(type: .twoLine(titleStyle: titlestyle,
                                                                        bodyStyle: descrstyle))
            
            let model = RowItem.ViewModel.init(labels: labels,
                                               leftElements: leftElement,
                                               rightElements: rightElement)
            return RowTableCell.CellModel(borderModel: model)
        }
    }
}
 
extension TransactionsController {
    enum Section: CaseIterable {
        case initial
    }
    
    enum CellModelType: Hashable {
        case title(String, String, UIImage, Double, String)
        case wholeTransaction(amount: Double, Currency: String)
    }
}

extension TransactionsController.CellModelType: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.tableCellModel.id == rhs.tableCellModel.id
    }
}
