//
//  ConfirmPasswordViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit
import Toast

class ConfirmPasswordViewController: UIViewController, AuthCoordinating, PasswordPresenterView {
    
    var finishFlow: stringClosure?
    var presenter: PasswordPresenterProtocol?
    
    let passwordTextField = PasswordTextField()
    let confirmButton = CustomButton(title: "Продолжить")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.screenColor
        
        title = "Введите пароль"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupPasswordViewController()
        setupToast()
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
    
    @objc func finish() {
        self.presenter?.checkPassword(password: passwordTextField.text ?? "")
        passwordTextField.resignFirstResponder()
    }
    
    func resultAfterCheck(result: PasswordCheck) {
        switch result {
        case .empty(let result):
            self.showToastMessage(text: result)
        case .minPassword(let result):
            self.showToastMessage(text: result)
        case .passwordWithSpace(let result):
            self.showToastMessage(text: result)
        case .success:
            self.finishFlow?(passwordTextField.text ?? "")
        }
    }
    
    func showToastMessage(text: String) {
        self.view.makeToast(text, duration: 3, position: .bottom)
    }
    
    func setupToast() {
        var style = ToastStyle()
        style.cornerRadius = 15
        style.backgroundColor = AppColors.errorRed
        style.horizontalPadding = 20
        style.messageFont = Fonts.fontCreator(font: .medium, size: 16)
        style.fadeDuration = 0.5
        
        ToastManager.shared.style = style
    }
}
