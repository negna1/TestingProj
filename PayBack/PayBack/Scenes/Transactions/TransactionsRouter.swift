//
//  TransactionsRouter.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import Foundation

protocol TransactionsRouter {
    func navigate2Details(title: String, description: String)
}

class TransactionsRouterImpl: TransactionsRouter {
    private weak var controller: TransactionsController?
    
    init(controller: TransactionsController) {
        self.controller = controller
    }
    
    func navigate2Details(title: String, description: String) {
        let vm = TransactionDetailsViewModel(title: title,
                                             description: description)
        let vc = TransactionDetailsController()
        vc.bind(with: vm)
        self.controller?.navigationController?.pushViewController(vc,
                                                                  animated: false)
    }
}
