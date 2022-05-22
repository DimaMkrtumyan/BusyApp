//
//  AllNetworksViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 07.04.22.
//

import Foundation

class AllNetworksViewModel {
    
    let networkManager = NetworkManager()
    
    var stories = [AllAdds]()
    var categories = [AllFlags]()
    var networks = [AllNetworks]()
    
    func getAllNetworks(type: Int, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .allNetworks, method: .get, body: .none, params: ["type": type], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let allNetworkData = try JSONDecoder().decode(AllNetworksData.self, from: data)
                    self.stories.append(contentsOf: allNetworkData.model.ads)
                    self.categories.append(contentsOf: allNetworkData.model.flags)
                    self.networks.append(contentsOf: allNetworkData.model.networks)
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
