//
//  ReceiptData.swift
//  Busy
//
//  Created by Davit Muradyan on 25.04.22.
//

import Foundation

struct ReceiptData: Decodable {
    let status: String
    let model: ReceiptModel
}

struct ReceiptModel: Decodable {
    let networkName: String
    let address: String
    let logoUrl: String
    let items: [ReceiptItem]
    let serviceFee: Int
    let totalPrice: Int
    let busyCoinsUsed: Bool
}

struct ReceiptItem: Decodable {
    let name: String
    let count: Int
    let price: Int
    let priceSum: Int
}
