//
//  LoginResponse.swift
//  Busy
//
//  Created by Davit Muradyan on 09.12.21.
//

import Foundation

struct LoginResponse: Decodable {
    let status: String
    let model: UserData
}

struct UserData: Decodable {
    let id: Int
    let phoneNumber: String
    let name: String
    let iconUrl: String
    let busyCoins: Int
    let birthDate: String
}
