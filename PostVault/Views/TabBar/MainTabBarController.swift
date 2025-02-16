//
//  MainTabBarController.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.setupNavigationBar()
        self.delegate = self
    }
    
    // MARK: - Functions
    /// Setup TabBar with Post and Favorites View
    private func setupTabs() {
        let postsVC = PostsViewController()
        postsVC.title = Constants.postTitle
        postsVC.tabBarItem = UITabBarItem(title: Constants.postTitle, image: UIImage(systemName: Constants.Images.bulletIcon), tag: 0)
        
        let favoritesVC = FavoritesViewController()
        favoritesVC.title = Constants.favoritesTitle
        favoritesVC.tabBarItem = UITabBarItem(title: Constants.favoritesTitle, image: UIImage(systemName: Constants.Images.filledHeartIcon), tag: 1)
        
        viewControllers = [postsVC, favoritesVC]
    }
    
    // MARK: - Navigation Bar Setup
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.logoutTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logoutTapped))
        updateNavigationTitle()
    }
    
    // MARK: - Actions
    @objc private func logoutTapped() {
        UserSessionManager.shared.logout()
        
        // Navigate to login screen
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navController
        }
    }
    
    /// Updates the navigation title when switching tabs
    private func updateNavigationTitle() {
        if let selectedVC = selectedViewController {
            navigationItem.title = selectedVC.title
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    // MARK: - Update Title When Switching Tabs
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateNavigationTitle()
    }
}
