//
//  AppGradient.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class AppGradient {
    static let shared = AppGradient()
    
    private init() {}
    
    func getGradient( colors: [UIColor], frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        
        gradient.colors = colors.map({ color in
            return color.cgColor
        })
        
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        gradient.locations = [0,1]
        
        return gradient
    }
}
