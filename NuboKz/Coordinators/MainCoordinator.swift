//
//  MainCoordinator.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let tabBarController = TabBarController()
        navigationController?.setViewControllers([tabBarController], animated: true)
    }
    
}
