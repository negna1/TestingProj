//
//  TransactionsRequest.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import Foundation

extension URLComponents {
    static func transactions(environment: Environment)-> Self {
        Self(scheme: "https",
             host: environment.host,
             path: "transactions")
    }
}

extension URLRequest {
    static func transactions(environment: Environment = .Production) -> Self {
        Self(components: .transactions(environment: environment))
            .add(httpMethodType: .GET)
    }
}

enum Environment {
    case Production
    case Test
}

extension Environment {
    var host: String {
        switch self {
        case .Production:
            return "api.payback.com"
        case .Test:
            return "api-test.payback.com"
        }
    }
}
