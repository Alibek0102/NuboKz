//
//  TasksPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import UIKit

protocol TasksPresenterProtocol {
    var viewController: TasksPresenterView { get set }
    
    func getTasksBySectionId(sectionId: String?)
}

protocol TasksPresenterView {
    func setTasks(tasks: [Task])
}

class TasksPresenter: TasksPresenterProtocol {
    
    var viewController: TasksPresenterView
    
    init(viewController: TasksPresenterView) {
        self.viewController = viewController
    }
    
    func getTasksBySectionId(sectionId: String?) {
        FirebaseLessonsManager.shared.getTasksBySectionId(sectionId: sectionId) { result in
            switch result {
            case .success(let data):
                self.viewController.setTasks(tasks: data)
            case .failure(_):
                print("error")
            }
        }
    }
}
