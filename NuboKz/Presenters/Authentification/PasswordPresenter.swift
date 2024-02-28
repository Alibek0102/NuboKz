//
//  PasswordPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit

protocol PasswordPresenterProtocol {
    var viewController: PasswordPresenterView { get set }
    
    func checkPassword(password: String)
}

protocol PasswordPresenterView {
    func resultAfterCheck(result: PasswordCheck)
}

enum PasswordCheck {
    case empty(result: String)
    case minPassword(result: String)
    case passwordWithSpace(result: String)
    case success
}

class PasswordPresenter: PasswordPresenterProtocol {
    var viewController: PasswordPresenterView
    
    init(viewController: PasswordPresenterView) {
        self.viewController = viewController
    }
    
    func containsSpace(_ string: String) -> Bool {
        return string.contains(" ")
    }
    
    func checkPassword(password: String) {
        if password.isEmpty {
            viewController.resultAfterCheck(result: .empty(result: "Введите пароль"))
            return
        }
        
        if password.count < 8 {
            viewController.resultAfterCheck(result: .minPassword(result: "Ко-во символов не должно быть меньше 8"))
            return
        }
        
        if containsSpace(password) {
            viewController.resultAfterCheck(result: .passwordWithSpace(result: "Пароль содержит пробелы"))
            return
        }
        
        viewController.resultAfterCheck(result: .success)
    }
    
}
