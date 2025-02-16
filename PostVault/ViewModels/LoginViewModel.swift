//
//  LoginViewModel.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    
    // MARK: - Dependencies
    private let userSessionManager: UserSessionManagerProtocol
    
    // MARK: - Reactive Input Properties
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    // MARK: - Computed Observables
    
    /// Validates email format using regex
    private var isEmailValid: Observable<Bool> {
        return email.map { email in
            let emailRegex = Constants.Validation.emailRegex
            return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        }
    }
    
    /// Validates password strength (8-15 characters, at least one number, one uppercase, one lowercase)
    private var isPasswordValid: Observable<Bool> {
        return password.map { password in
            let passwordRegex = Constants.Validation.passwordRegex
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        }
    }
    
    /// Determines if login button should be enabled
    var isValid: Observable<Bool> {
        return Observable.combineLatest(isEmailValid, isPasswordValid) { $0 && $1 }
    }
    
    // MARK: - Initializer
    init(userSessionManager: UserSessionManagerProtocol = UserSessionManager.shared) {
        self.userSessionManager = userSessionManager
    }
    
    // MARK: - Login Action
    
    /// Attempts login and returns an Observable result
    func login() {
        userSessionManager.saveLogin(email: email.value)
    }
}
