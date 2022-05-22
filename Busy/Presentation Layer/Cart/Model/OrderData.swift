//
//  OrderData.swift
//  Busy
//
//  Created by Davit Muradyan on 10.03.22.
//

import Foundation

struct OrderData: Encodable {
    let cartId: Int
    let mode: Int
    let itemCounts: [Int : Int]
    let busyCoinsUsed: Bool
}
