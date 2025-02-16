//
//  UIView+Extensions.swift
//  PostVault
//
//  Created by Dishant Choudhary on 16/02/25.
//

import UIKit

extension UIView {
    /// Adds a gradient background with given colors
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.masksToBounds = true
        
        // Remove existing gradient layers to avoid duplicates
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// Ensures gradient resizes correctly
    func updateGradientFrame() {
        self.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.forEach { $0.frame = self.bounds }
    }
}
