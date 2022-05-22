//
//  ForgotPinViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import Foundation

class ForgotPinViewModel {
    
    let networkManager = NetworkManager()
    
    func verifyPhone(_ phoneNumber: String, completion: @escaping (Result<String, NetworkError>) -> ()) {
        networkManager.setupRequest(path: .forgotPinPhoneVeify, method: .get, body: nil, params: ["phoneNumber" : phoneNumber], header: .application_json) { result in
            switch result {
            case .success(let data):
                do {
                    let forgotPinResponse = try JSONDecoder().decode(ForgotPinResponse.self, from: data)
                    completion(.success(forgotPinResponse.value))
                } catch {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func verifySMS(_ phoneNumber: String, _ pinCode: String, completion: @escaping (Result<Void, NetworkError>) -> ()) {
        let verifSMSBody = ForgotPinSMSBody(phoneNumber: phoneNumber, code: pinCode)
        
        networkManager.setupRequest(path: .forgotPinVerifySMS, method: .post, body: verifSMSBody, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
    
    func changePin(_ phoneNumber: String, _ pinCode: String, completion: @escaping (Result<Void, NetworkError>) -> ()) {
        let changePinBody = ChangePinBody(phoneNumber: phoneNumber, code: pinCode)
        networkManager.setupRequest(path: .forgotPinChange, method: .put, body: changePinBody, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
