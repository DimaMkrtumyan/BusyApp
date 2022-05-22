//
//  AddReservation.swift
//  Busy
//
//  Created by Davit Muradyan on 10.02.22.
//

import Foundation

struct AddReservation: Encodable {
    let branchId: Int
    let peopleCount: Int
    let hallId: Int
    let reservationTime: String
}
