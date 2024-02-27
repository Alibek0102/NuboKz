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
        return viewController
    }
    
    func createConfirmPasswordViewController() -> ConfirmPasswordViewController {
        let viewController = ConfirmPasswordViewController()
        return viewController
    }
    
    func createSendUserViewController() -> SendUserViewController {
        let viewController = SendUserViewController()
        return viewController
    }
}
