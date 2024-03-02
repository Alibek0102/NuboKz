//
//  MissionCoordinator.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 02.03.2024.
//

import UIKit

protocol MissionCoordinating {
    var finishFlow: boolClosure? { get set }
    var performEvent: performMissionCoordinatorEvents? { get set }
}

class MissionCoordinator: Coordinator {
    var navigationController: UINavigationController?
    var taskId: String?
    
    let homeModule = HomeModule()
    let missionNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .overCurrentContext
        navigationController.navigationController?.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()
    
    func start() {
        let viewController = homeModule.taskDescriptionViewController()
        viewController.taskId = taskId
        viewController.finishFlow = { result in
            if(result){
                self.close()
            }
        }
        viewController.performEvent = { result in
            self.executeEvent(eventTypes: result)
        }
        missionNavigationController.setViewControllers([viewController], animated: true)
        navigationController?.present(missionNavigationController, animated: true)
    }
    
    func executeEvent(eventTypes: MissionCoordinatorEvents) {
        switch eventTypes {
        case .missionsViewController:
            startMissionsViewController()
        }
    }
    
    func startMissionsViewController() {
        let viewController = MissionsViewController()
        missionNavigationController.pushViewController(viewController, animated: true)
    }
    
    func close() {
        self.navigationController?.dismiss(animated: true)
    }
}
