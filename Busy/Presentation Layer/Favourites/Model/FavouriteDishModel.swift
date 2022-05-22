//
//  FavouriteDishModel.swift
//  Busy
//
//  Created by Davit Muradyan on 20.01.22.
//

import Foundation

struct FavouriteDishModel: Decodable {
    let status: String
    let model: FavouriteDishData
}

struct FavouriteDishData: Decodable {
    let networkId: Int
    let name: String
    let branches: [FavDishBranch]
    let items: [FavouriteItem]
}

struct FavDishBranch: Decodable {
    let id: Int
    let address: String
}

struct FavouriteItem: Decodable {
    let id: Int
    let picUrl: String
    let name: String
    let price: Int
    let discountedPrice: Int
    let isFavorite: Bool
}

