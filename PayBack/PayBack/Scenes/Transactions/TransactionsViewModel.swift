//
//  TransactionsViewModel.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 01.02.23.
//

import Combine
import UIKit
import Components
import CombineCore

protocol TransactionsViewModelType {
    func transform(input: TransactionsViewModelInput) -> TransactionsViewModelOutput
}

struct TransactionsViewModelInput {
    let categoryChange: AnyPublisher<TransactionsResponseItem.CategoryType, Never>
    let selection: AnyPublisher<TransactionsController.CellModelType, Never>
}

typealias TransactionsViewModelOutput = AnyPublisher<TransactionsState, Never>

enum TransactionsState: Equatable {
    case idle([TransactionsController.CellModelType])
    case loading(showLoad: Bool)
    case showAlert(String, String, String)
    case showError(String)
}

class TransactionsViewModel: TransactionsViewModelType {
    private typealias CellType = TransactionsController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var stateSubject = PassthroughSubject<TransactionsState, Never>()
    private var currentDataSource: [CellType] = []
    private var transactioItems: [TransactionsResponseItem] = []
    private var originaltransactioItems: [TransactionsResponseItem] = []
    private var currentCategoryType: TransactionsResponseItem.CategoryType?
    private var input: TransactionsViewModelInput?
    private let core = LocalTransactionCoreData()
    private var transactionFullAmount: Double {
        let doubles = transactioItems.compactMap({Double($0.transactionDetail?.value?.amount ?? 0)})
        return doubles.reduce(0,+)
    }
    
    private let router: TransactionsRouter?
    init(router: TransactionsRouter) {
        self.router = router
    }
    
    func transform(input: TransactionsViewModelInput) -> TransactionsViewModelOutput {
        self.input = input
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        categoryChangeSink(input: input)
        selectionSink(input: input)
        
        currentDataSource = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.fetchTransactions()
        }
        
        let idle: TransactionsViewModelOutput = Just(.idle(currentDataSource))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return Publishers.Merge(idle, stateSubject).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func categoryChangeSink(input: TransactionsViewModelInput) {
        input.categoryChange
            .sink(receiveValue: { [unowned self] category in
                switch category {
                case .removeFilters:
                    self.transactioItems = self.originaltransactioItems
                default:
                    self.transactioItems = self.originaltransactioItems.filter({$0.transactionCategory == category})
                }
                self.updateWithTransactions()
            }).store(in: &cancellables)
    }
    
    private func selectionSink(input: TransactionsViewModelInput) {
        input.selection
            .sink {  [unowned self] cellType  in
                switch cellType {
                case .title(let title, _, _, _, _):
                    self.router?.navigate2Details(title: "Your name and description", description: title)
                case .wholeTransaction(_,_):
                    break
                }
            }.store(in: &cancellables)
    }
}

//MARK: - Convert service call -
extension TransactionsViewModel {
    func fetchTransactions()  {
        let response  =  MockService.shared.fetchAsync(filename: "PBTransactions", with: TransactionsResponse.self)
        self.stateSubject.send(.loading(showLoad: false))
        // MARK: - I WROTE REACHIBILITY IN MY OWN PACKAGE AND BECAUSE JSON IS NOT HERE I ALSOW WROTE HERE.
        if !Reachability.isConnectedToNetwork(){
            self.stateSubject.send(.showError("Check your internet connection"))
            self.fetchCoreDataItems()
            return
        }
        switch response {
        case .success(let succResp):
            core.saveTransactions(transactions: succResp)
            self.originaltransactioItems = succResp.items ?? []
            self.filterWitDate()
            self.updateWithTransactions()
        case .failure(let error):
            self.fetchCoreDataItems()
            self.stateSubject.send(.showError(error.localizedDescription))
        }
    }
    
    private func fetchCoreDataItems() {
        Task {
            self.originaltransactioItems = await core.fetchRequest()
            self.filterWitDate()
            self.updateWithTransactions()
        }
    }
}

//MARK: - Success Response functions and variable -
extension TransactionsViewModel {
    private var detailsAboutTransaction: [(String, String, UIImage, Double, String)] {
        transactioItems.map({ item in
            let dispayName = item.partnerDisplayName ?? ""
            let dispayDescr = item.transactionDetail?.description ?? ""
            let title = "\(dispayName) - \(dispayDescr)"
            let amount = Double(item.transactionDetail?.value?.amount ?? 0)
            let currency = item.transactionDetail?.value?.currency ?? ""
            let icon = item.transactionCategory.icon ?? UIImage()
            let date = item.transactionDetail?.bookingDate?.toDate()?.yearMonthDayHourAndMinute ?? ""
            return (title, date, icon, amount, currency)
        })
    }
    
    private func filterWitDate() {
        originaltransactioItems = originaltransactioItems.compactMap({$0}).sorted(by: {($0.transactionDetail?.bookingDate?.toDate() ?? Date()) < ($1.transactionDetail?.bookingDate?.toDate() ?? Date())})
        self.transactioItems = originaltransactioItems
    }
    
    private func updateWithTransactions() {
        currentDataSource = detailsAboutTransaction.compactMap({ title in
            CellType.title(title.0, title.1, title.2, title.3, title.4)
        })
        let currency = transactioItems.first?.transactionDetail?.value?.currency
        currentDataSource.insert(CellType.wholeTransaction(amount: transactionFullAmount,
                                                           Currency: currency ?? "GEL"),
                                 at: 0)
        self.stateSubject.send(.idle(currentDataSource))
    }
}

extension TransactionsViewModel {
    //TODO: - it should call like Task { await callConvertProd()}
    func fetchTransactionsProd() async  {
        let urlRequest = URLRequest.transactions()
        let response = await URLSession.shared.fetchAsync(for: urlRequest,
                                                          with: TransactionsResponse.self)
        self.stateSubject.send(.loading(showLoad: false))
        switch response {
        case .success(let succResp):
            core.saveTransactions(transactions: succResp)
            self.originaltransactioItems = succResp.items ?? []
            self.filterWitDate()
            self.updateWithTransactions()
        case .failure(let error):
            self.fetchCoreDataItems()
            self.stateSubject.send(.showError(error.localizedDescription))
        }
    }
}

extension TransactionsViewModel {
    var getStateSubject: PassthroughSubject<TransactionsState, Never> {
        stateSubject
    }
    
    var getInput: TransactionsViewModelInput? {
        input
    }
}
