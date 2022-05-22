//
//  PersonalDetails.swift
//  Busy
//
//  Created by Davit Muradyan on 19.01.22.
//

import Foundation

class PersonalDetails: Decodable {
    let status: String
    let model: UserDetails
}

class UserDetails: Decodable {
    let id: Int
    let phoneNumber: String
    let name: String
    let iconUrl: String
    let busyCoins: Int
    let birthDate: String
}
