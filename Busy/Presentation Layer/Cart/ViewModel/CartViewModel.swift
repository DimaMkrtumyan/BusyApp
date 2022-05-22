//
//  CartViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 10.03.22.
//

import Foundation

class CartViewModel {
    let networkManager = NetworkManager()
    let storageManager = StorageManager()
    var networks = [CartNetwork]()
    var reservationDates = [CartReservations]()
    var items = [CartItems]()
    
    func getCartData(completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .getCart, method: .get, body: nil, params: ["userId": storageManager.getUserId()], header: .application_json) { [self] result in
            switch result {
            case .success(let data):
                do {
                    let cartBody = try JSONDecoder().decode(CartData.self, from: data)
                    networks.append(contentsOf: cartBody.model.networks)
                    networks.forEach { network in
                        self.reservationDates.append(contentsOf: network.reservations)
                    }
                    reservationDates.forEach { reservation in
                        self.items.append(contentsOf: reservation.items)
                    }
                    completion(.success(Void()))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    func placeOrder(cartId: Int,completion: @escaping(Result<Void, NetworkError>) -> ()) {
        let orderData = OrderData(cartId: cartId, mode: 0, itemCounts: [:], busyCoinsUsed: true)
        networkManager.setupRequest(path: .placeOrder, method: .post, body: orderData, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
