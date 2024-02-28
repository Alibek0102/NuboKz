//
//  LoginViewController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit
import Toast

class ConfirmEmailViewController: ViewController, AuthCoordinating, EmailPresenterView, UITextFieldDelegate {
    
    var finishFlow: stringClosure?
    
    var presenter: EmailPresenterProtocol?
    
    let emailTextField = EmailTextField()
    let confirmButton = CustomButton(title: "Продолжить")
    
    let leftView: UIView = {
        let view = UIView()
        
        let gradient = AppGradient.shared.getGradient(colors: [AppColors.appBlue, AppColors.lightGreen], frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        
        view.layer.insertSublayer(gradient, at: 0)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 70).isActive = true
        view.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.screenColor
        
        title = "Введите email"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupEmailViewController()
        setupNavigatioLeftView()
        setupAppTitle()
        
        confirmButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        
        self.setupToast()
    }
    
    private func setupEmailViewController() {
        view.addSubview(emailTextField)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22),
            
            confirmButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            confirmButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 22),
            confirmButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -22)
        ])
    }
    
    private func setupNavigatioLeftView() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
    }
    
    private func setupAppTitle() {
        
        let label = UILabel()
        label.text = "NUBO.KZ"
        label.font = Fonts.fontCreator(font: .bold, size: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        leftView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: leftView.centerYAnchor)
        ])
    }
    
    @objc func finish() {
        presenter?.checkEmail(email: emailTextField.text ?? "")
        
        emailTextField.resignFirstResponder()
    }
    
    func resultAfterCheck(result: EmailCheck) {
        switch result {
        case .emptyEmail(let result):
            self.showToastMessage(text: result)
        case .uncorrectEmail(let result):
            self.showToastMessage(text: result)
        case .success:
            self.finishFlow?(emailTextField.text ?? "")
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
