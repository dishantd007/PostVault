//
//  UIApplication+Extensions.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import UIKit

extension UIApplication {
    static func changeRootViewController(to viewController: UIViewController) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        // Smooth transition (optional)
        UIView.transition(with: window,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}
