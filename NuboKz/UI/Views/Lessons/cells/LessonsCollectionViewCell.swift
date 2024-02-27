//
//  LessonsCollectionViewCell.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit

class LessonsCollectionViewCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        
        addActiveLayer()
    }
    
    func addActiveLayer () {
        layer.sublayers?.removeAll()
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.lineJoin = .round
        
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 105, height: 125), cornerRadius: 20).cgPath
        
        layer.addSublayer(shapeLayer)
    }
    
    func createLayer() {
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4.0
        shapeLayer.lineDashPattern = [8,20]
        
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 105, height: 125), cornerRadius: 20).cgPath
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 0.1
        startAnimation.toValue = 1

        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = 0.5
        endAnimation.toValue = 1.1
        
        let animations = CAAnimationGroup()
        animations.animations = [startAnimation, endAnimation]
        animations.duration = 3
        animations.repeatCount = 1
        
        shapeLayer.add(animations, forKey: "MyAnimation")
        
        layer.addSublayer(shapeLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            self.addActiveLayer()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
