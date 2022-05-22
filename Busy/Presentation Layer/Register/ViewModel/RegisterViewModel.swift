//
//  AuthViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 07.12.21.
//

import UIKit

class RegisterViewModel {
    
    let networkManager = NetworkManager()
    let storageManager = StorageManager()
    
    func register(name: String, phoneNumber: String, completion: @escaping(Result<String,NetworkError>) -> ()) {
        let registerBody = RegisterBody(name: name, phoneNumber: phoneNumber)
        networkManager.setupRequest(path: .register, method: .post, body: registerBody, params: nil, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                    print(registerResponse)
                    completion(.success(registerResponse.value))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func verifyPhone(phoneNumber: String, pinCode: String, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        let verifyBody = RegisterVerifyBody(phoneNumber: phoneNumber, code: pinCode)
        networkManager.setupRequest(path: .registerVerifyPin, method: .post, body: verifyBody, params: nil, header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let verifyResponse = try JSONDecoder().decode(RegisterVerifyResponse.self, from: data)
                    print(verifyResponse)
                    completion(.success(Void()))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func setupPin(phoneNumber: String, pinCode: String, completion: @escaping (Result<Void, NetworkError>) -> ()) {
        let pinBody = SetPinBody(phoneNumber: phoneNumber, code: pinCode)
        networkManager.setupRequest(path: .setupPin, method: .post, body: pinBody, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                self.storageManager.saveUserCredentials(phoneNumber: phoneNumber, pinCode: pinCode)
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
