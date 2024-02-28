//
//  LessonsCollectionViewCell.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit

class LessonsCollectionViewCell: UICollectionViewCell {
    
    var story: Story? {
        didSet {
            guard let story = story else { return }
            
            let url = URL(string: story.image)
            
            let queue = DispatchQueue.global(qos: .utility)
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            queue.async {
                guard let url = url, let data = try? Data(contentsOf: url) else { return }
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tintColor = AppColors.textGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.widthAnchor.constraint(equalToConstant: 30).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        
        addActiveLayer()
        setupImage()
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20 - 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func addActiveLayer () {
        layer.sublayers?.removeAll()
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.strokeColor = UIColor.systemBlue.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 3.0
        shapeLayer.lineJoin = .round
        
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 105, height: 125), cornerRadius: 20).cgPath
        
        layer.insertSublayer(shapeLayer, at: 0)
    }
    
    func setupImage() {
        addSubview(imageView)
        
        imageView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
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
