//
//  UserSessionManager.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import Foundation

protocol UserSessionManagerProtocol: AnyObject {
    func saveLogin(email: String)
    func isUserLoggedIn() -> Bool
    func getUserEmail() -> String?
    func logout()
}

class UserSessionManager: UserSessionManagerProtocol {
  
    // MARK: - Singleton
    static let shared = UserSessionManager()
    
    // MARK: - Keys
    private let emailKey = "userEmail"
    private let isLoggedInKey = "isLoggedIn"

    private init() {}

    // MARK: - Session Management

    /// Saves user login session
    func saveLogin(email: String) {
        UserDefaults.standard.set(email, forKey: emailKey)
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
    }

    /// Returns `true` if user is logged in
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: isLoggedInKey)
    }

    /// Returns stored user email
    func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: emailKey)
    }

    /// Logs out the user and clears session data
    func logout() {
        UserDefaults.standard.removeObject(forKey: emailKey)
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
    }
}
