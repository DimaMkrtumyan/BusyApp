//
//  HistoryViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 23.04.22.
//

import Foundation

class HistoryViewModel {
    let networkManager = NetworkManager()
    var historyModel = [HistoryModel]()
    
    func getHistory(completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .orderHistory, method: .get, body: nil, params: nil, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let historyData = try JSONDecoder().decode(HistoryData.self, from: data)
                    self.historyModel.append(contentsOf: historyData.models)
                    completion(.success(Void()))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
