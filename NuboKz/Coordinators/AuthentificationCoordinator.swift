//
//  AuthentificationCoordiantor.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class AuthentificationCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    private let module = AuthModule()
    
    var finishFlow: boolClosure?
    
    var user = User(email: nil, password: nil)
    
    func start() {
        showConfirmEmailViewController()
    }
    
    func showConfirmEmailViewController() {
        let viewController = module.createConfirmEmailViewController()
        
        viewController.finishFlow = { email in
            self.user.email = email
            self.showConfirmPasswordViewController()
        }
        
        navigationController?.setViewControllers([viewController], animated: true)
    }
    
    func showConfirmPasswordViewController() {
        let viewController = module.createConfirmPasswordViewController()
        
        viewController.finishFlow = { password in
            self.user.password = password
            self.showUserAuthFlow()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showUserAuthFlow() {
        let viewController = module.createSendUserViewController()
        viewController.user = self.user
        
        viewController.finishFlow = { result in
            if(result == true) {
                self.finishFlow?(true)
            } else {
                self.showConfirmEmailViewController()
            }
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
}
