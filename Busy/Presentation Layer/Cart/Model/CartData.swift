//
//  CartModel.swift
//  Busy
//
//  Created by Davit Muradyan on 10.03.22.
//

import Foundation

struct CartData: Decodable {
    let status: String
    let model: CartModel
}

struct CartModel: Decodable {
    let networks: [CartNetwork]
}

struct CartNetwork: Decodable {
    let networkId: Int
    let name: String
    let reservations: [CartReservations]
}
struct CartReservations: Decodable {
    let cartId: Int
    let address: String
    let orderDate: String
    let items: [CartItems]
    let mode: Int
}
struct CartItems: Decodable {
    let itemModelId: Int
    let name: String
    let parameterNames: [CartItemParameters]
    let count: Int
    let price: Int
    let discountedPrice: Int
    let picUrl: String
}

struct CartItemParameters: Decodable {
    let parameterId: Int
    let chosenOptions: [String]
}
