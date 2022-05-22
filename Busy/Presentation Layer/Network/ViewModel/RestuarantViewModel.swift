//
//  RestuarantViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 01.02.22.
//

import Foundation

class RestuarantViewModel {
    let networkManager = NetworkManager()
    let storageManager = StorageManager()
    var addresses = [RestuarantBranch]()
    var freeSeatCount: Int?
    var dishes = [RestuarantItem]()
    var bannerData = [String]()
    var categories = [RestuarantCategory]()
    var halls = [RestuarantHall]()
    var activeReservations = [ActiveReservations]()
    var currentReservationId: Int?
    
    func getRestuarantData(networkID: Int, completion: @escaping(Result<RestuarantModel, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .restuarant, method: .get, body: nil, params: ["NetworkId": networkID, "UserId": storageManager.getUserId()], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let restuarantResponse = try JSONDecoder().decode(RestuarantModel.self, from: data)
                    self.addresses += restuarantResponse.model.branches
                    self.dishes.append(contentsOf: restuarantResponse.model.items)
                    self.bannerData.append(contentsOf: restuarantResponse.model.bannerPicUrls)
                    self.categories.insert(contentsOf: restuarantResponse.model.categories, at: 0)
                    self.halls.append(contentsOf: restuarantResponse.model.halls)
                    self.activeReservations.append(contentsOf: restuarantResponse.model.activeReservations)
                    completion(.success(restuarantResponse))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    func setFavourites(itemId: Int, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .setFavourite, method: .post, body: nil, params: ["itemId" : itemId], header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func addItem(item: ItemModel, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        let body = AddItem(reservationId: currentReservationId!, item: item)
        networkManager.setupRequest(path: .orderAddItem, method: .post, body: body, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
