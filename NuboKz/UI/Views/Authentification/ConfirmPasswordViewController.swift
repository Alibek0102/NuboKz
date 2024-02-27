//
//  ConfirmPasswordViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class ConfirmPasswordViewController: UIViewController, AuthCoordinating {
    var finishFlow: stringClosure?
    
    let passwordTextField = PasswordTextField()
    let confirmButton = CustomButton(title: "Продолжить")
    
    @objc func finish() {
        self.finishFlow?(passwordTextField.text ?? "")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.screenColor
        
        title = "Введите пароль"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupPasswordViewController()
        
        confirmButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
    }
    
    private func setupPasswordViewController() {
        view.addSubview(passwordTextField)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),
            
            confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22)
        ])
    }
}
