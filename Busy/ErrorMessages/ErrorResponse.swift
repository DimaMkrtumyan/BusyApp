//
//  ErrorResponse.swift
//  Busy
//
//  Created by Davit Muradyan on 23.02.22.
//

import Foundation

struct ErrorResponse: Decodable {
    let status: String
    let message: String
}
