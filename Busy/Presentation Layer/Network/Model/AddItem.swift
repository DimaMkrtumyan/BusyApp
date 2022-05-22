//
//  AddItem.swift
//  Busy
//
//  Created by Davit Muradyan on 07.03.22.
//

import Foundation

struct AddItem: Encodable {
    let reservationId: Int
    let item: ItemModel
}

struct ItemModel: Encodable {
    let id: Int
    let count: Int
    let chosenParameters: [String: String]
}
