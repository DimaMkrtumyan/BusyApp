//
//  StorageManager.swift
//  Busy
//
//  Created by Davit Muradyan on 20.01.22.
//

import Foundation

final class StorageManager {
    
    func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    func getToken() -> String? {
        let token = UserDefaults.standard.string(forKey: "token")
        return token
    }
    
    func saveUserCredentials(phoneNumber: String, pinCode: String) {
        UserDefaults.standard.set(phoneNumber, forKey: "phoneNumber")
        UserDefaults.standard.set(pinCode, forKey: "pinCode")
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.string(forKey: "phoneNumber") != nil && UserDefaults.standard.string(forKey: "pinCode") != nil
    }
    
    func saveUserId(_ id: Int) {
        UserDefaults.standard.set(id, forKey: "ID")
    }

    func getUserId() -> Int {
        if let id = UserDefaults.standard.value(forKey: "ID") as? Int {
            return id
        } else {
            return -1
        }
    }
    
    func saveUserImage(_ image: String) {
        UserDefaults.standard.set(image, forKey: "UserImage")
    }
    
    func getUserImage() -> String {
        return UserDefaults.standard.string(forKey: "UserImage")!
    }
    
    func saveDeviceToken(deviceToken: String) {
        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
    }
    
    func getDeviceToken() -> String? {
        let deviceToken = UserDefaults.standard.string(forKey: "deviceToken")
        return deviceToken
    }
}
