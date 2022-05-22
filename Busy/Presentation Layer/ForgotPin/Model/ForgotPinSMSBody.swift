//
//  ForgotPinSMSBody.swift
//  Busy
//
//  Created by Davit Muradyan on 29.12.21.
//

import Foundation

struct ForgotPinSMSBody: Encodable {
    let phoneNumber: String
    let code: String
}
