//
//  AuthModule.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class AuthModule {
    func createConfirmEmailViewController() -> ConfirmEmailViewController {
        let viewController = ConfirmEmailViewController()
        let presenter = EmailPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func createConfirmPasswordViewController() -> ConfirmPasswordViewController {
        let viewController = ConfirmPasswordViewController()
        let presenter = PasswordPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func createSendUserViewController() -> SendUserViewController {
        let viewController = SendUserViewController()
        let presenter = SendUserPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
