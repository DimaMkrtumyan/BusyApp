//
//  ActiveOrdersViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 23.04.22.
//

import Foundation

class ActiveOrdersViewModel {
    let networkManager = NetworkManager()
    
    var activeOrderItems = [ActiveOrderModel]()
    
    func getActiveOrders(completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .activeOrders, method: .get, body: nil, params: nil, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let activeOrdersBody = try JSONDecoder().decode(ActiveOrderData.self, from: data)
                    self.activeOrderItems.append(contentsOf: activeOrdersBody.models)
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
