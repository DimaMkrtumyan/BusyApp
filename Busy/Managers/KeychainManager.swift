//
//  KeychainManager.swift
//  Busy
//
//  Created by Davit Muradyan on 09.12.21.
//

import Foundation
import KeychainAccess

protocol UserToken {
    var token: String? { get}
}

final class KeychainManager {
    
    let keychain = Keychain(service: "com.Busy")
    let accessTokenKey = "AccessToken"
    
    // MARK: - Functions
    
    /// Save token in keychain
    func saveToken(token: String) {
        do {
            try keychain.set(token, key: accessTokenKey)
        } catch let error {
            print(error)
        }
    }
    
    /// Check user token
    func isUserLoggedIn() -> Bool {
        return keychain[accessTokenKey] != nil
    }
    
    /// Get token from keychain
    func getAccessToken() -> String? {
        let token = try? keychain.getString(accessTokenKey)
        return token
    }
    
    /// Delete token from keychain
    func removeData() {
        do {
            try keychain.removeAll()
        } catch let error {
            debugPrint("Error: \(error)")
        }
    }
    
    /// Remove all keychain data when run first time
    func resetIfNeeded() {
        if !UserDefaults.standard.bool(forKey: "hasRunBefore") {
            // Remove Keychain items here
            do {
                try keychain.removeAll()
            } catch let error {
                debugPrint("Error: \(error)")
            }
            
            // Update the flag indicator
            UserDefaults.standard.set(true, forKey: "hasRunBefore")
        }
    }
}

