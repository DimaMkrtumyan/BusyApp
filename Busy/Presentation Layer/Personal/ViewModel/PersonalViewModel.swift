//
//  PersonalViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 12.02.22.
//

import Foundation

class PersonalViewModel {
    
    let networkManager = NetworkManager()
    let keychainManager = KeychainManager()
    
    let personalSettings = ["Բանկային քարտեր", "Կարգավորումներ"]
    let orders = ["Ակտիվ պատվերներ", "Պատվերների պատմություն"]
    let other  = ["Ծանուցումներ", "Կապ մեզ հետ", "Գաղտնիության պայմանագիր", "Դուրս գալ հաշվից"]
    
    var id = Int()
    var phoneNumber = String()
    var name = String()
    var iconUrl = String()
    var busyCoins = Int()
    var birthDate = String()
    
    func getPersonalDetails(completion: @escaping(Result<PersonalDetails, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .userDetails, method: .get, body: .none, params: .none , header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let personalDetails = try JSONDecoder().decode(PersonalDetails.self, from: data)
                    self.id = personalDetails.model.id
                    self.phoneNumber = personalDetails.model.phoneNumber
                    self.name = personalDetails.model.name
                    self.iconUrl = personalDetails.model.iconUrl
                    self.busyCoins = personalDetails.model.busyCoins
                    self.birthDate = personalDetails.model.birthDate
                    completion(.success(personalDetails))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func signOut(completion: @escaping(Result< Void, NetworkError>) -> ()) {
        
        networkManager.setupRequest(path: .logOut, method: .delete, header: .application_json) { result in
            switch result {
                
            case .success(_):
                self.keychainManager.removeData()
                completion(.success(Void()))
                
            case .failure(let error):
                completion(.failure(.responseError(error.errorMessage)))
            }
        }
    }
    
}
