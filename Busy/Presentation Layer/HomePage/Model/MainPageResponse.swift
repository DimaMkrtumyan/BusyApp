//
//  MainPageBody.swift
//  Busy
//
//  Created by Davit Muradyan on 01.01.22.
//

import Foundation

struct MainPageResponse: Decodable {
    let status: String
    let model: WholeModel
}

struct WholeModel: Decodable {
    let networkAds: [Story]
    let activeOrderCount: Int
    let networksSorted: [RestuarantSection]
}

struct Story: Decodable {
    let id: Int
    let image: String
}

struct RestuarantSection: Decodable {
    let type: Int
    let typeName: String
    let networks: [RestuarantOption]
}

struct RestuarantOption: Decodable {
    let id: Int
    let name: String
    let description: String
    let iconUrl: String
    let imageUrl: String
}
