//
//  SignInPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit

protocol SendUserPresenterProtocol {
    var viewController: SendUserPresenterView { get set }
    
    func signIn(user: User?)
}

protocol SendUserPresenterView {
    func signInResult(result: SignInResult)
}

enum SignInResult {
    case success, notFound
}

class SendUserPresenter: SendUserPresenterProtocol {
   
    var viewController: SendUserPresenterView
    
    init(viewController: SendUserViewController) {
        self.viewController = viewController
    }
    
    func signIn(user: User?) {
        guard let user = user else { return }
        FirebaseManager.shared.signIn(user: user) { responce in
            switch responce {
            case .success(_):
                self.viewController.signInResult(result: .success)
            case .failure(_):
                self.viewController.signInResult(result: .notFound)
            }
        }
    }
}
