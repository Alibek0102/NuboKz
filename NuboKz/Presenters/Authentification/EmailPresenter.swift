//
//  EmailPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit

protocol EmailPresenterProtocol {
    var viewController: EmailPresenterView { get set }
    
    func checkEmail(email: String)
}

protocol EmailPresenterView {
    
    func resultAfterCheck(result: EmailCheck)
    
}

enum EmailCheck {
    case emptyEmail(result: String)
    case uncorrectEmail(result: String)
    case success
}

class EmailPresenter: EmailPresenterProtocol {
    var viewController: EmailPresenterView
    
    init(viewController: EmailPresenterView) {
        self.viewController = viewController
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func checkEmail(email: String) {
        if email.isEmpty {
            viewController.resultAfterCheck(result: .emptyEmail(result: "Введите почту"))
            return
        }
        
        if !isValidEmail(email) {
            viewController.resultAfterCheck(result: .uncorrectEmail(result: "Некорректный email"))
            return
        }
        
        viewController.resultAfterCheck(result: .success)
        
    }
}
