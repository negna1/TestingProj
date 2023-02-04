//
//  TransactionsController.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 01.02.23.
//

import Combine
import UIKit
import Foundation
import SnapKit
import Components


class TransactionsController: UIViewController {
    private var cancellables: [AnyCancellable] = []
    private var viewModel: TransactionsViewModelType!
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var chipsView: ChipsView = {
        let chipsView = ChipsView()
        chipsView.translatesAutoresizingMaskIntoConstraints = false
        return chipsView
    }()
    
    private lazy var activityView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.tintColor = .orange
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private lazy var dataSource = makeDataSource()
    private let categoryChange = PassthroughSubject<TransactionsResponseItem.CategoryType, Never>()
    private let selection = PassthroughSubject<CellModelType, Never>()
    
    public func bind(with viewModel: TransactionsViewModelType!) {
        self.viewModel = viewModel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .orange,
                               tintColor: .blue,
                               title: Constant.title,
                               preferredLargeTitle: true)
    }
    
    override func viewDidLoad() {
        configureUI()
        configureChipsView()
        bind(to: viewModel)
    }
    
    private func configureUI() {
        constrain()
        registerCells()
        tableView.dataSource = dataSource
    }
    
    private func configureChipsView() {
        let models = TransactionsResponseItem.CategoryType.allCases.map({$0.chips})
        let model = ChipsViewModel(dataSource: models) { index in
            self.categoryChange.send(TransactionsResponseItem.CategoryType.init(rawValue: index + 1) ?? .third)
            self.chipsView.configure(viewModel: self.viewModelChips(index: index))
        }
        chipsView.configure(viewModel: model)
    }
    
    private func viewModelChips(index: Int) -> ChipsViewModel {
        let models = TransactionsResponseItem.CategoryType.allCases.map({StandardChipsCellViewModel.init(title: $0.categoryName, state: index + 1 == $0.rawValue ? .active : .disabled)})
        
        let model = ChipsViewModel(dataSource: models) { index in
            self.categoryChange.send(TransactionsResponseItem.CategoryType.init(rawValue: index + 1) ?? .third)
            self.chipsView.configure(viewModel: self.viewModelChips(index: index))
        }
        return model
    }
    
    private func registerCells() {
        tableView.register(RowTableCell.self,
                           forCellReuseIdentifier: "RowTableCell")
    }
    
    private func bind(to viewModel: TransactionsViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let input = TransactionsViewModelInput(categoryChange: categoryChange.eraseToAnyPublisher(),
                                               selection: selection.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: TransactionsState) {
        switch state {
        case .idle(let cells):
            update(with: cells, animate: false)
        case .showAlert(let from, let to, let commission):
            let message = "You have converted \(from) from \(to) with commission \(commission)"
            showSimpleAlert(title: Constant.title, message: message)
        case .showError(let message):
            showSimpleAlert(title: Constant.error, message: message)
        case .loading(showLoad: let showLoad):
            showLoad ? activityView.startAnimating() : activityView.stopAnimating()
        }
    }
}
 
//MARK: - Data source and reload
 extension TransactionsController {
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

//MARK: - Table View cell selection
extension TransactionsController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        
        selection.send(snapshot.itemIdentifiers[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Alert
extension TransactionsController {
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Done",
                                      style: UIAlertAction.Style.default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK: - Constrain
extension TransactionsController {
    private func constrain() {
        constrainChipsView()
        constrainTableView()
        constrainActivityView()
    }
    private func constrainTableView() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.trailing.leading.bottom.equalToSuperview()
        }
    }
    
    private func constrainChipsView() {
        self.view.addSubview(chipsView)
        
        chipsView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.leading.equalToSuperview()
        }
    }
    
    private func constrainActivityView() {
        self.tableView.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(60)
        }
        activityView.startAnimating()
    }
}

//MARK: - Getters for test
extension TransactionsController{
    var getTableView: UITableView {
        tableView
    }
    
    var getDataSource: UITableViewDiffableDataSource<Section,  CellModelType> {
        dataSource
    }
}
