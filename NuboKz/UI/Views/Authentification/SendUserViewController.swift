//
//  SendUserViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit
import Lottie

class SendUserViewController: UIViewController {
    
    var animationView = LottieAnimationView()
    
    var user: User?
    
    var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Подождите немного..."
        label.font = Fonts.fontCreator(font: .bold, size: 22)
        label.textColor = AppColors.textGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true
        
        setupLoading()
    }
    
    func setupLoading() {
        animationView = .init(name: "student")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 0.5
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        view.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loadingLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
