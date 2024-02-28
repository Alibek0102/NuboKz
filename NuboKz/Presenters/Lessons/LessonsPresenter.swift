//
//  LessonsPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit

protocol LessonsPresenterProtocol: AnyObject {
    var viewController: LessonsPresenterView { get set }
    
    func getSubjects()
    func getStories()
    func getSections(subject: Subject)
}

protocol LessonsPresenterView: AnyObject {
    func setSubjects(subjects: [Subject])
    func setStories(stories: [Story])
    func setSections(sections: [Section])
}

class LessonsPresenter: LessonsPresenterProtocol {
    var viewController: LessonsPresenterView
    
    init(viewController: LessonsPresenterView) {
        self.viewController = viewController
    }
    
    func getSubjects() {
        let userId = UserDefaultsManager.shared.getUserId()
        
        FirebaseLessonsManager.shared.getAllSubjects(userId: userId) { result in
            switch result {
            case .success(let data):
                self.viewController.setSubjects(subjects: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getStories() {
        FirebaseStoriesManager.shared.getStories { result in
            switch result {
            case .success(let data):
                self.viewController.setStories(stories: data)
            case .failure(_):
                print("error")
            }
        }
    }
    
    func getSections(subject: Subject) {
        FirebaseLessonsManager.shared.getSectionsOfSubjectBySegment(subject: subject) { result in
            switch result {
            case .success(let data):
                self.viewController.setSections(sections: data)
            case .failure(_):
                print("error")
            }
        }
    }
}
