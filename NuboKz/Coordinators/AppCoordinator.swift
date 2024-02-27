//
//  AppCoordinator.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    var isAuth: Bool = false
    
    func start() {
        if isAuth {
            showMainFlow()
        } else {
            showAuthFlow()
        }
    }
    
    func showAuthFlow() {
        let authCoordinator = AuthentificationCoordinator()
        authCoordinator.finishFlow = { result in
            if result {
                self.isAuth = true
            }
            
            self.start()
        }
        authCoordinator.navigationController = self.navigationController
        authCoordinator.start()
    }
    
    func showMainFlow() {
        let mainCoordinator = MainCoordinator()
        navigationController?.setNavigationBarHidden(true, animated: false)
        mainCoordinator.navigationController = self.navigationController
        mainCoordinator.start()
    }
}
