//
//  FavouritesModel.swift
//  Busy
//
//  Created by Davit Muradyan on 20.01.22.
//

import Foundation

struct FavouriteRestuarantModel: Decodable {
    let status: String
    let models: [FavouriteRestuarantData]
}

struct FavouriteRestuarantData: Decodable {
    let category: String
    let networks: [FavouriteNetwork]
}

struct FavouriteNetwork: Decodable {
    let id: Int
    let name: String
    let description: String
    let logoUrl: String
    let category: Int
}
