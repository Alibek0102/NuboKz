//
//  SendUserViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit
import Lottie

class SendUserViewController: UIViewController, SendUserPresenterView {
    
    var animationView = LottieAnimationView()
    
    var finishFlow: boolClosure?
    
    var notFoundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .userNotFound
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var presenter: SendUserPresenterProtocol?
    
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
        signIn()
    }
    
    func signIn() {
        presenter?.signIn(user: self.user)
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
    
    func setupErrorView() {
        view.willRemoveSubview(animationView)
        
        loadingLabel.text = "Пользователь не найден"
        
        view.addSubview(notFoundImageView)
        
        NSLayoutConstraint.activate([
            notFoundImageView.heightAnchor.constraint(equalToConstant: 200),
            notFoundImageView.widthAnchor.constraint(equalToConstant: 200),
            notFoundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            notFoundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.willRemoveSubview(animationView)
    }
    
    func signInResult(result: SignInResult) {
        switch result {
        case .success:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.finishFlow?(true)
            }
        case .notFound:
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.setupErrorView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.finishFlow?(false)
                }
            }
        }
    }
}
