//
//  MockUserSessionManager.swift
//  PostVault
//
//  Created by Dishant Choudhary on 16/02/25.
//

class MockUserSessionManager: UserSessionManagerProtocol {
    var savedEmail: String?
    var isLoggedIn: Bool = false

    func saveLogin(email: String) {
        savedEmail = email
        isLoggedIn = true
    }

    func isUserLoggedIn() -> Bool {
        return isLoggedIn
    }

    func getUserEmail() -> String? {
        return savedEmail
    }

    func logout() {
        savedEmail = nil
        isLoggedIn = false
    }
}
