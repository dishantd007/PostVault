//
//  LoginViewModelTests.swift
//  PostVaultTests
//
//  Created by Dishant Choudhary on 16/02/25.
//

import XCTest
import RxSwift
import RxCocoa

@testable import PostVault

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockUserSession: MockUserSessionManager!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockUserSession = MockUserSessionManager()
        viewModel = LoginViewModel(userSessionManager: mockUserSession)
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        viewModel = nil
        mockUserSession = nil
        disposeBag = nil
        super.tearDown()
    }
    
    // MARK: - Test Email Validation
    func testEmailValidation_ValidEmail() {
        // Given: Ensure both inputs are valid
        viewModel.email.accept("user@test.com")
        viewModel.password.accept("ValidP@ssword1") // Must be a valid password

        // Expectation
        let expectation = XCTestExpectation(description: "Valid email should pass validation")

        // When: Subscribe to `isValid`
        var isValidState: Bool?
        let disposable = viewModel.isValid.subscribe(onNext: { isValid in
            isValidState = isValid
            expectation.fulfill()
        })

        // Then: Wait for observable emission
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(isValidState ?? false, "Expected isValid to be true but got \(isValidState ?? false)")

        disposable.dispose()
    }
    
    func testEmailValidation_InvalidEmail() {
        let expectation = XCTestExpectation(description: "Invalid email should fail validation")
        
        viewModel.email.accept("invalid-email")
        
        viewModel.isValid.subscribe(onNext: { isValid in
            XCTAssertFalse(isValid)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: -  Test Password Validation
    func testPasswordValidation_ValidPassword() {
        // Given: Ensure email is valid, otherwise combineLatest won't emit
        viewModel.email.accept("user@test.com") // Valid email
        viewModel.password.accept("ValidP@ssword1") // Valid password

        // Expectation
        let expectation = XCTestExpectation(description: "Valid password should pass validation")

        // When: Subscribe to `isValid`
        var isValidState: Bool?
        let disposable = viewModel.isValid.subscribe(onNext: { isValid in
            print("🔍 isValid emitted: \(isValid)")
            isValidState = isValid
            expectation.fulfill()
        })

        // Then: Wait for observable emission
        wait(for: [expectation], timeout: 2.0)
        XCTAssertTrue(isValidState ?? false, "Expected isValid to be true but got \(isValidState ?? false)")

        disposable.dispose()
    }
    
    func testPasswordValidation_InvalidPassword() {
        let expectation = XCTestExpectation(description: "Invalid password should fail validation")
        
        viewModel.password.accept("weak")
        
        viewModel.isValid.subscribe(onNext: { isValid in
            XCTAssertFalse(isValid)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Test Login Button State
    func testLoginButton_EnabledWhenValid() {
        let expectation = XCTestExpectation(description: "Login button should be enabled when valid email and password are entered")
        
        viewModel.email.accept("user@test.com")
        viewModel.password.accept("StrongP@ss1")
        
        viewModel.isValid.subscribe(onNext: { isValid in
            XCTAssertTrue(isValid)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoginButton_DisabledWhenInvalid() {
        let expectation = XCTestExpectation(description: "Login button should be disabled when email or password is invalid")
        
        viewModel.email.accept("invalid-email")
        viewModel.password.accept("123")
        
        viewModel.isValid.subscribe(onNext: { isValid in
            XCTAssertFalse(isValid)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: -  Test Login Action
    func testLogin_SavesUserSession() {
        viewModel.email.accept("user@test.com")
        viewModel.login()
        
        XCTAssertEqual(mockUserSession.savedEmail, "user@test.com")
        XCTAssertTrue(mockUserSession.isLoggedIn)
    }
}
