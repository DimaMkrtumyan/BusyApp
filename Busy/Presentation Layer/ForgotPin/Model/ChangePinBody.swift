//
//  ChangePinBody.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import Foundation

struct ChangePinBody: Encodable {
    let phoneNumber: String
    let code: String
}
