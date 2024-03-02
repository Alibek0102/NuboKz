//
//  MainCoordinator.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    let homeModule = HomeModule()
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.performEvent = { result in
            self.executeEvent(event: result)
        }
        navigationController?.setViewControllers([tabBarController], animated: true)
    }
    
    func executeEvent(event: MainCoordinatorEvents) {
        switch event {
        case .showDescription(let taskId):
            showDescriptionViewController(id: taskId)
        }
    }
    
    private func showDescriptionViewController(id: String?){
        let missionCoordinator = MissionCoordinator()
        missionCoordinator.navigationController = self.navigationController
        missionCoordinator.taskId = id
        missionCoordinator.start()
    }

}
