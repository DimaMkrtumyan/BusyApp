//
//  UpdateUserDetials.swift
//  Busy
//
//  Created by Davit Muradyan on 22.04.22.
//

import Foundation

struct UpdateUserDetials: Encodable {
    let id: Int
    let phoneNumber: String
    let name: String
    let birthDate: String
    let image: String
}
