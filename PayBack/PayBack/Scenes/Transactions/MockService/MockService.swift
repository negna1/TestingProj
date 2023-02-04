//
//  MockService.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 01.02.23.
//

import CombineCore
import Foundation


final class MockService {
    static var shared = MockService()
    
    func fetchAsync<Response: Decodable>(filename: String,
                                         with type: Response.Type) -> Result<Response, Error> {
        guard let jsonData = self.readLocalFile(forName: filename) else {
            return .failure(ErrorType.noData)
        }
        do {
            let decodedData = try JSONDecoder().decode(type,
                                                       from: jsonData)
            return .success(decodedData)
        } catch {
            return .failure(ErrorType.noData)
        }
    }

    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

