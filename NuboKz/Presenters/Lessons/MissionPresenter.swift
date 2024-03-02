//
//  MissionPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 02.03.2024.
//

import UIKit

protocol MissionPresenterProtocol {
    var viewController: MissionPresenterView? { get set }
    
    func getMissionsByTaskId(taskId: String?)
}

protocol MissionPresenterView {
    func setMissions(data: [Mission])
}

class MissionPresenter: MissionPresenterProtocol {
    
    var viewController: MissionPresenterView?
    
    init(viewController: MissionPresenterView? = nil) {
        self.viewController = viewController
    }
    
    func getMissionsByTaskId(taskId: String?) {
        FirebaseLessonsManager.shared.getMissionsByTaskId(taskId: taskId) { result in
            switch result {
            case .success(let data):
                self.viewController?.setMissions(data: data)
            case .failure(_):
                print("error")
            }
        }
    }
    
}
