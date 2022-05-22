//
//  ActiveOrderBody.swift
//  Busy
//
//  Created by Davit Muradyan on 23.04.22.
//

import Foundation

struct ActiveOrderData: Decodable {
    let status: String
    let models: [ActiveOrderModel]
}

struct ActiveOrderModel: Decodable {
    let networkId: Int
    let branchId: Int
    let cartId: Int
    let resId: Int
    let networkName: String
    let address: String
    let networkIconUrl: String
    let reservationDate: String
}
