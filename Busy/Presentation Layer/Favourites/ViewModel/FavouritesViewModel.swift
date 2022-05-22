//
//  FavouritesViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 17.01.22.
//

import Foundation

class FavouritesViewModel {
    
    let networkManager = NetworkManager()
    let keychainManager = KeychainManager()
    let storageManager = StorageManager()
    var favRestuarants = [FavouriteRestuarantData]()
    
    var cafes = [FavouriteNetwork]()
    var fastFood = [FavouriteNetwork]()
    var restuarants = [FavouriteNetwork]()
    
    var favouriteDishes = [FavouriteItem]()
    var favDishBranches = [FavDishBranch]()
    
    func getFavouriteRestuarants(completion: @escaping (Result<Void, NetworkError>) -> ()) {
        let id = storageManager.getUserId()
        networkManager.setupRequest(path: .favouriteRestuarants, method: .get, body: nil, params: ["userId": id], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let favRestuarants = try JSONDecoder().decode(FavouriteRestuarantModel.self, from: data)
                    self.favRestuarants.append(contentsOf: favRestuarants.models)
                    favRestuarants.models.forEach { model in
                        switch model.category {
                        case "Cafe":
                            self.cafes.append(contentsOf: model.networks)
                        case "Restaurant":
                            self.restuarants.append(contentsOf: model.networks)
                        case "FastFood":
                            self.fastFood.append(contentsOf: model.networks)
                        default:
                            break
                        }
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
    
    func getFavouriteDishes(networkId: Int, completion: @escaping (Result<[FavDishBranch], NetworkError>) -> ()) {
        let userId = StorageManager().getUserId()
        networkManager.setupRequest(path: .favouriteDishes, method: .get, body: nil, params: ["userId": userId, "NetworkId": networkId], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let favouriteDishes = try JSONDecoder().decode(FavouriteDishModel.self, from: data)
                    self.favouriteDishes.append(contentsOf: favouriteDishes.model.items)
                    self.favDishBranches.append(contentsOf: favouriteDishes.model.branches)
                    completion(.success(self.favDishBranches))
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
}
