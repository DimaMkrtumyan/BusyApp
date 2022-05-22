//
//  ItemViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 09.02.22.
//

import Foundation

class ItemViewModel {
    let networkManager = NetworkManager()
    let storageManager = StorageManager()
    
    var parameters = [OrderItemParameter]()
    var itemData: OrderItemData?
    func getItem(itemId: Int,completion: @escaping(Result<OrderItemData, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .orderItem, method: .get, body: nil, params: ["id" : itemId, "userId" : storageManager.getUserId()], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let itemResponse = try JSONDecoder().decode(OrderItemModel.self, from: data)
                    self.parameters.append(contentsOf: itemResponse.model.parameters)
                    self.itemData = itemResponse.model
                    completion(.success(itemResponse.model))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
