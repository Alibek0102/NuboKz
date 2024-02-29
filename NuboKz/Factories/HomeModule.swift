//
//  HomeModule.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import Foundation


class HomeModule {
    
    func tasksViewController() -> TasksViewController {
        let viewController = TasksViewController()
        let presenter = TasksPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
}
