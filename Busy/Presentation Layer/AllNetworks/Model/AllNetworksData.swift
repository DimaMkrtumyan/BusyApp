//
//  AllNetworksData.swift
//  Busy
//
//  Created by Davit Muradyan on 07.04.22.
//

import Foundation

struct AllNetworksData: Decodable {
    let status: String
    let model: AllNetworksModel
}

struct AllNetworksModel: Decodable {
    let networks: [AllNetworks]
    let ads: [AllAdds]
    let flags: [AllFlags]
}
struct AllNetworks: Decodable {
    let logoUrl: String
    let picUrl: String
    let name: String
    let description: String
    let category: Int
    let flagIds: [Int]
}

struct AllAdds: Decodable {
    let id: Int
    let image: String
}

struct AllFlags: Decodable {
    let id: Int
    let name: String
}
