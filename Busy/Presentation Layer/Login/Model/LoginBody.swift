//
//  LoginBody.swift
//  Busy
//
//  Created by Davit Muradyan on 09.12.21.
//

import Foundation

struct LoginBody: Encodable {
    let phoneNumber: String
    let pinCode: String
    let deviceToken: String
}
