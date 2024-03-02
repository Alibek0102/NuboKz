//
//  ImageGradient.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 01.03.2024.
//

import UIKit

class ImageGradient {
    static let shared = ImageGradient()
    
    private init() {}
    
    func createGradientLayer(frame: CGRect, endColor: UIColor) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = frame
        
        gradientLayer.colors = [UIColor.clear.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0.4, 1]
        
        return gradientLayer
    }
}
