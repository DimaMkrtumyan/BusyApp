//
//  OrderItem.swift
//  Busy
//
//  Created by Davit Muradyan on 09.02.22.
//

import Foundation

struct OrderItemModel: Decodable {
    let status: String
    let model: OrderItemData
}

struct OrderItemData: Decodable {
    let id: Int
    let imageUrl: String
    let logoUrl: String
    let networkName: String
    let name: String
    let ingridients: String
    let price: Int
    let discountedPrice: Int
    let parameters: [OrderItemParameter]
    let isFavorite: Bool
    let isInOrder: Bool
}

struct OrderItemParameter: Decodable {
    let id: Int
    let name: String
    let type: Int
    let variants: [String]
}
