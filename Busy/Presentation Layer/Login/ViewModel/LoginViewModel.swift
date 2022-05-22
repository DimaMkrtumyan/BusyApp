//
//  LoginViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 09.12.21.
//

import Foundation

class LoginViewModel {
    let networkManager = NetworkManager()
    let storageManager = StorageManager()
    
    func checkNumber(phoneNumber: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .checkNumberLogin, method: .get, body: nil, params: ["number" : phoneNumber], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let checkNumberResponse = try JSONDecoder().decode(CheckNumberResponse.self, from: data)
                    completion(.success(checkNumberResponse.message))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(let message):
                completion(.failure(.responseError(message.errorMessage)))
            }
        }
    }
    
    func login(phoneNumber: String, pinCode: String, completion: @escaping(Result<Void,NetworkError>) -> ()) {
        
        guard let deviceToken = storageManager.getDeviceToken() else {return}
        let loginBody = LoginBody(phoneNumber: phoneNumber, pinCode: pinCode, deviceToken: deviceToken)
        
        networkManager.setupRequest(path: .login, method: .post, body: loginBody, params: nil, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    self.storageManager.saveUserId(loginResponse.model.id)
                    self.storageManager.saveUserCredentials(phoneNumber: phoneNumber, pinCode: pinCode)
                    completion(.success(Void()))
                }
                catch {
                    completion(.failure(.serverError))
                }
            case .failure(let message):
                completion(.failure(.responseError(message.errorMessage)))
            }
        }
    }
}
