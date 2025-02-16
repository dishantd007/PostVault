//
//  Constants.swift
//  PostVault
//
//  Created by Dishant Choudhary on 14/02/25.
//

import Foundation
import UIKit

struct Constants {
    static let emptyStateMessage = "No posts yet, Stay tuned!"
    static let postTitle = "Posts"
    static let favoritesTitle = "Favorites"
    static let logoutTitle = "Logout"
    static let enterEmailText = "Enter email"
    static let enterPasswordText = "Enter password"
    static let submitText = "Submit"
    
    struct Validation {
        static let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        static let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,15}$"
    }
    
    struct Images {
        static let bulletIcon = "list.bullet"
        static let filledHeartIcon = "heart.fill"
        static let heartIcon = "heart"
    }
    
    struct CellIdentifier {
        static let postTableViewCell = "PostTableViewCell"
    }
    
    struct Colors {
        static let tealColor = UIColor(red: 0.00, green: 0.50, blue: 0.50, alpha: 1.0) // Teal (#008080)
        static let seaGreenColor = UIColor(red: 0.18, green: 0.55, blue: 0.34, alpha: 1.0) // Sea Green (#2E8B57)
    }
}
