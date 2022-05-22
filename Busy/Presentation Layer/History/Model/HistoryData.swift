//
//  HistoryData.swift
//  Busy
//
//  Created by Davit Muradyan on 23.04.22.
//

import Foundation

struct HistoryData: Decodable {
    let status: String
    let models: [HistoryModel]
}

struct HistoryModel: Decodable {
    let date: String
    let orders: [HistoryOrders]
}

struct HistoryOrders: Decodable {
    let networkName: String
    let address: String
    let logoUrl: String
    let totalPrice: Int
    let reservationId: Int
}

