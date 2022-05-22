//
//  ReserveViewModel.swift
//  Busy
//
//  Created by Davit Muradyan on 09.02.22.
//

import Foundation

class ReserveViewModel {
    
    let networkManager = NetworkManager()
    let months = ["January","February","March","April","May","June","July",
    "August","September","October","November","December"]
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    func addReservation(branchId: Int, peopleCount: String, hallId: Int, reservationTime: String, completion: @escaping(Result<Void, NetworkError>) -> ()) {
        let body = AddReservation(branchId: branchId, peopleCount: Int(peopleCount)!, hallId: hallId, reservationTime: reservationTime)
        
        networkManager.setupRequest(path: .orderAddReservation, method: .post, body: body, params: nil, header: .application_json) { result in
            switch result {
            case .success(_):
                completion(.success(Void()))
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
    }
}
