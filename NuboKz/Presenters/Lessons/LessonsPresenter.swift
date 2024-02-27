//
//  LessonsPresenter.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit

protocol LessonsPresenterProtocol: AnyObject {
    var viewController: UIViewController { get set }
    
    func getSubjects()
}

protocol LessonsPresenterView: AnyObject {
    
}

class LessonsPresenter: LessonsPresenterProtocol {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func getSubjects() {
        FirebaseManager.shared.getAllSubjects { response in
            
            switch response {
            case .success(let subjects):
                print(subjects)
            case .failure(_):
                print("error")
            }
            
        }
    }
}
