//
//  UITableView+Extension.swift
//  PostVault
//
//  Created by Dishant Choudhary on 16/02/25.
//

import UIKit

extension UITableView {
    /// Sets an empty state message when the table view has no data
    func setEmptyState(_ message: String) {
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.textColor = .gray
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.numberOfLines = 0
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    /// Removes the empty state message when data is available
    func removeEmptyState() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
