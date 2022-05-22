//
//  ReceiptViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 25.04.22.
//

import Foundation

class ReceiptViewModel {
    let networkManager = NetworkManager()
    var items = [ReceiptItem]()
    var logo = String()
    var networkName = String()
    var address = String()
    var fee = String()
    var total = String()
    
    func getReceipt(resId: Int, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .receipt, method: .get, body: nil, params: ["resId" : resId], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let receiptData = try JSONDecoder().decode(ReceiptData.self, from: data)
                    self.items.append(contentsOf: receiptData.model.items)
                    self.logo = receiptData.model.logoUrl
                    self.networkName = receiptData.model.networkName
                    self.address = receiptData.model.address
                    self.fee = "\(receiptData.model.serviceFee) AMD"
                    self.total = "\(receiptData.model.totalPrice) AMD"
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
