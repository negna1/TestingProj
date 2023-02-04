//
//  TransactionDetailsController.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import Combine
import UIKit
import Foundation
import SnapKit
import Components


class TransactionDetailsController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private var viewModel: TransactionDetailsViewModelType!
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    private lazy var dataSource = makeDataSource()
    
    public func bind(with viewModel: TransactionDetailsViewModelType!) {
        self.viewModel = viewModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureCustomNav(backgoundColor: .orange)
    }
    
    override func viewDidLoad() {
        configureUI()
        bind(to: viewModel)
    }
    
    private func configureUI() {
        constrain()
        registerCells()
        tableView.dataSource = dataSource
    }
    
    private func constrain() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    private func registerCells() {
        tableView.register(RowTableCell.self,
                           forCellReuseIdentifier: "RowTableCell")
    }
    
    private func bind(to viewModel: TransactionDetailsViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let input = TransactionDetailsViewModelInput()
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: TransactionDetailsState) {
        switch state {
        case .idle(let cells):
            update(with: cells, animate: false)
        }
    }
    
}

//MARK: - Data source and reload
extension TransactionDetailsController {
    func makeDataSource() -> UITableViewDiffableDataSource<Section,  CellModelType> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, type in
                let cell = tableView.dequeueReusableCell(withIdentifier: type.tableCellModel.nibIdentifier) as? ConfigurableTableCell
                cell?.configure(with: type.tableCellModel)
                return cell ?? UITableViewCell()
            }
        )
    }
    
    func update(with models: [CellModelType], animate: Bool) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,  CellModelType>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(models, toSection: .initial)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

extension TransactionDetailsController{
    var getTableView: UITableView {
        tableView
    }
    
    var getDataSource: UITableViewDiffableDataSource<Section,  CellModelType> {
        dataSource
    }
}
