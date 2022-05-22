//
//  NetworkManager.swift
//  Busy
//
//  Created by Davit Muradyan on 09.12.21.
//

import Foundation
import Alamofire

enum Paths: String {
    case register = "api/Authenticate/registerWithoutPinCode"
    case registerVerifyPin = "api/Authenticate/VerifyPhoneBeforePincode"
    case setupPin = "api/Authenticate/SetUserPinCde"
    case checkNumberLogin = "api/Authenticate/CheckNumber"
    case login = "api/Authenticate/loginUser"
    case forgotPinPhoneVeify = "api/Authenticate/ForgotPasswordSendCode"
    case forgotPinVerifySMS = "api/Authenticate/ForgotPassVerifyPincode"
    case forgotPinChange = "api/Authenticate/ForgotPasswordChange"
    case mainPageData = "api/MainPage/GetMainPage"
    case seachHomePageData = "api/MainPage/NetworkSearch"
    case userDetails = "api/PersonalPage/GetUserDetails"
    case favouriteRestuarants = "api/FavoritesPage/GetFavoriteNetworks"
    case favouriteDishes = "api/FavoritesPage/GetFavoriteNetworkItems"
    case restuarant = "api/NetworkPage/GetNetworkPage"
    case setFavourite = "api/Item/SetFavorite"
    case orderItem = "api/Item/OrderItem"
    case orderAddReservation = "api/Order/AddReservation"
    case orderAddItem = "api/Order/AddSingleItemCart"
    case getCart = "api/Order/GetCart"
    case placeOrder = "api/Order/PlaceOrder"
    case allNetworks = "api/MainPage/GetNetworksByType"
    case updateUserDetails = "api/PersonalPage/UpdateUserDetails"
    case activeOrders = "api/PersonalPage/GetActiveOrders"
    case orderHistory = "api/PersonalPage/GetCompletedOrders"
    case receipt = "api/PersonalPage/GetCheck"
    case logOut = "api/Authenticate/LogOut"
}

enum RequestMethod: String {
    case put = "PUT"
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HeaderType {
    case application_json
    case multipart_form_data
    case application_x_www_form_urlencoded
    
    var value: HTTPHeaders {
        switch self {
        case .application_json:
            return ["Content-Type" : "application/json"]
        case .multipart_form_data:
            return ["Content-Type": "multipart/form-data"]
        case .application_x_www_form_urlencoded:
            return ["Content-Type" : "application_x_www_form_urlencoded"]
        }
    }
}

enum NetworkError: Error {
    case serverError
    case responseError(_ errorMessage: String)
    
    var errorMessage: String {
        switch self {
        case .serverError:
            return "Something went wrong"
        case .responseError(let errMessage):
            return errMessage
        }
    }
}


class NetworkManager {
    
    let keychain = KeychainManager()
    let base = "https://d3flmciphroo6e.cloudfront.net/"
    let storageManager = StorageManager()
    
    func setupRequest(path: Paths, method: RequestMethod, body: Encodable? = nil, params: [String: Any]? = nil, header: HeaderType, completion: @escaping((Result<Data,NetworkError>) -> Void)) {
        
        var queries = ""
        if let params = params {
            queries = params.passingQuery()
        }
        
        let url = URL(string: base + path.rawValue + queries)
        var request = URLRequest(url: url!)
        request.httpMethod = method.rawValue
        request.setValue(header.value[0].value, forHTTPHeaderField: "Content-Type")
        
        if let userToken = keychain.getAccessToken(), userToken.count > 0 {
            request.setValue("Bearer " + userToken, forHTTPHeaderField: "Authorization")
        }

        if let body = body {
            if let jsonData = body.toJSONData() {
                request.httpBody = jsonData
            }
        }
        
        AF.request(request).validate().responseJSON { response in
            if (200...299) ~= response.response?.statusCode ?? -1 {
                self.handlingHeaders(response: response)
                completion(.success(response.data!))
            } else {
                do {
                    if let data = response.data {
                        let json = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(.responseError(json.message)))
                    }
                }  catch {
                    completion(.failure(.serverError))
                }
            }
        }
    }
    
   private func handlingHeaders(response: AFDataResponse<Any>) {
        let headers = response.response?.headers
        if let accessToken = headers?.dictionary["Authorization"] {
            keychain.saveToken(token: accessToken)
        }
    }
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
