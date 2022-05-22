//
//  RestuarantData.swift
//  Busy
//
//  Created by Davit Muradyan on 24.01.22.
//

import Foundation

struct RestuarantModel: Decodable {
    let status: String
    let model: RestuarantData
    
}
struct RestuarantData: Decodable {
    let networkId: Int
    let branches: [RestuarantBranch]
    let networkLogoUrl: String
    let name: String
    let halls: [RestuarantHall]
    let bannerPicUrls: [String]
    let activeReservations: [ActiveReservations]
    let categories: [RestuarantCategory]
    let items: [RestuarantItem]
}

struct RestuarantBranch: Decodable {
    let branchId: Int
    let address: String
//    let workDays: WorkDay
}

struct WorkDay: Decodable {
    let day: Int
    let startTime: String
    let endTime: String
}
struct RestuarantHall: Decodable {
    let id: Int
    let branchId: Int
    let name: String
    let availableSeats: Bool
}

struct ActiveReservations: Decodable {
    let id: Int
    let time: String
    let basketItemCount: Int
}

struct RestuarantCategory: Decodable {
    let id: Int
    let name: String
}

struct RestuarantItem: Decodable {
    let id: Int
    let picUrl: String
    let name: String
    let price: Int
    let discountedPrice: Int
    let isFavorite: Bool
    let category: Int
    let isInCart: Bool
}
