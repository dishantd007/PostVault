//
//  LoginViewController.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Dependencies
    /// View model for login business logic
    private let viewModel = LoginViewModel()
    /// For Memory management
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.updateGradientFrame()
    }
    
    // MARK: - UI Setup
    /// Configure Email TextField,  Password textfield and login Button
    private func setupUI() {
        view.applyGradient(
            colors: [Constants.Colors.tealColor, Constants.Colors.seaGreenColor],
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )

        self.emailTextField.placeholder = Constants.enterEmailText
        self.emailTextField.borderStyle = .roundedRect
        self.emailTextField.autocapitalizationType = .none
        self.emailTextField.keyboardType = .emailAddress
        
        self.passwordTextField.placeholder = Constants.enterPasswordText
        self.passwordTextField.borderStyle = .roundedRect
        self.passwordTextField.isSecureTextEntry = true
        
        self.loginButton.setTitle(Constants.submitText, for: .normal)
        self.loginButton.isEnabled = false // Initially disabled
        self.loginButton.backgroundColor = .lightGray
        self.loginButton.setTitleColor(.white, for: .normal)
        self.loginButton.layer.cornerRadius = 5
    }
    
    // MARK: - Rx Bindings
    /// Bind user input to view model, Observe Login button state and handle login button tap
    private func setupBindings() {
        self.emailTextField.rx.text.orEmpty.bind(to: viewModel.email).disposed(by: disposeBag)
        self.passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        
        self.viewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.viewModel.isValid
            .map { $0 ? UIColor.systemBlue : UIColor.lightGray }
            .bind(to: loginButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        self.loginButton.rx.tap
            .withLatestFrom(viewModel.isValid) // Ensure valid login before proceeding
            .filter { $0 }
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.login()
                self?.navigateToMainTabBar()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Navigation
    private func navigateToMainTabBar() {
        // Navigate to the Main TabBar
        DispatchQueue.main.async {
            let mainTabBar = MainTabBarController()
            let navController = UINavigationController(rootViewController: mainTabBar)
            UIApplication.changeRootViewController(to: navController)
        }
    }
}
