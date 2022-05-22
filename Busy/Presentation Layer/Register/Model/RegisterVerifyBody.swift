//
//  RegisterVerifyBody.swift
//  Busy
//
//  Created by Davit Muradyan on 27.12.21.
//

import Foundation

struct RegisterVerifyBody: Encodable {
    let phoneNumber: String
    let code: String
}
