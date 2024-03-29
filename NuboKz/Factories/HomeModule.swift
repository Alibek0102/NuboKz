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
    
    func taskDescriptionViewController() -> TaskDescriptionViewController {
        let viewController = TaskDescriptionViewController()
        let presenter = TaskDescriptionPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func missionsViewController() -> MissionsViewController {
        let viewController = MissionsViewController()
        let presenter = MissionPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func testViewController() -> TestViewController {
        let viewController = TestViewController()
        return viewController
    }
}
