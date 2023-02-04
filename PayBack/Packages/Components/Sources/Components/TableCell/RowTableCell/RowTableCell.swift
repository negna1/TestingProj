//
//  File.swift
//  
//
//  Created by Nato Egnatashvili on 16.11.22.
//

import UIKit
import SnapKit

public class RowTableCell: UITableViewCell,  ConfigurableTableCell {

    private lazy var textField: RowItem = {
        let txt = RowItem()
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.contentView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview().inset(6)
        }
    }
    
    public func configure(with model: TableCellModel) {
        if let model = model as? CellModel {
            self.textField.configure(with: model.borderModel)
        }
    }
}

extension RowTableCell {
    public struct CellModel: TableCellModel, Hashable {
        public static func == (lhs: CellModel, rhs: CellModel) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
           hasher.combine(id)
         }
        
        public var nibIdentifier: String = "RowTableCell"
        public var height: Double = UITableView.automaticDimension
        public var borderModel: RowItem.ViewModel
        public let id: UUID = UUID()
        public init(borderModel: RowItem.ViewModel) {
            self.borderModel = borderModel
        }
    }
}

