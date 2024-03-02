//
//  TaskDescriptionPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 01.03.2024.
//

import Foundation

protocol TaskDescriptionPresenterProtocol {
    var viewController: TaskDescriptionPresenterView { get set }
    
    func getTaskDescription(id: String?)
}

protocol TaskDescriptionPresenterView {
    func setTaskDescription(description: TaskDescription)
}

class TaskDescriptionPresenter: TaskDescriptionPresenterProtocol {
    
    var viewController: TaskDescriptionPresenterView
    
    init(viewController: TaskDescriptionPresenterView) {
        self.viewController = viewController
    }
    
    func getTaskDescription(id: String?) {
        FirebaseLessonsManager.shared.getTaskDescription(taskId: id) { result in
            switch result {
            case .success(let data):
                self.viewController.setTaskDescription(description: data)
            case .failure(_):
                print("error")
            }
        }
    }
}
