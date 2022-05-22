//
//  SettingsViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 22.04.22.
//

import Foundation

class SettingsViewModel {
    
    let networkManager = NetworkManager()
    let storageManager = StorageManager()
    
    
    func updateUserData(name: String, phone: String, dob: String, image: String, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        let body = UpdateUserDetials(id: storageManager.getUserId(), phoneNumber: phone, name: name, birthDate: dob, image: image)
        
        networkManager.setupRequest(path: .updateUserDetails, method: .put, body: body, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(.responseError(error.errorMessage)))
            }
        }
    }
}
