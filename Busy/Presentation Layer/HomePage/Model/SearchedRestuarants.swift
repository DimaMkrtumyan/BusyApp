//
//  SearchedRestuarants.swift
//  Busy
//
//  Created by Davit Muradyan on 10.01.22.
//

import Foundation

struct SearchedRestuarants: Decodable {
    let status: String
    let models: [SearchedData]
}

struct SearchedData: Decodable {
    let id: Int
    let name: String
    let description: String
    let iconUrl: String
    let imageUrl: String
}
