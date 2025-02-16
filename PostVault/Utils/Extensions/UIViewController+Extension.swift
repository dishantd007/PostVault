//
//  UIViewController+Extension.swift
//  PostVault
//
//  Created by Dishant Choudhary on 15/02/25.
//

import UIKit

extension UIViewController {
    func showCommentsPopup(_ comments: [Comment]) {
        guard presentedViewController == nil else { return } // Prevent multiple alerts

        let message = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 4
        
        for comment in comments.prefix(5) {
            // Bold comment name
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
                .paragraphStyle: paragraphStyle
            ]
            let boldText = NSAttributedString(string: "• \(comment.name)\n", attributes: boldAttributes)
            
            // Normal comment body
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14, weight: .regular),
                .paragraphStyle: paragraphStyle
            ]
            let normalText = NSAttributedString(string: "\(comment.body)\n\n", attributes: normalAttributes)
            
            message.append(boldText)
            message.append(normalText)
        }
        
        let alert = UIAlertController(title: "Comments\n", message: "", preferredStyle: .actionSheet)
        // Set attributed text using KVC (Key-Value Coding)
        alert.setValue(message, forKey: "attributedMessage")
        //alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        
        // Proper way to get the top view controller in iOS 15+
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first,
           let rootViewController = window.rootViewController {
            
            DispatchQueue.main.async {
                rootViewController.present(alert, animated: true)
            }
        }
    }
}
