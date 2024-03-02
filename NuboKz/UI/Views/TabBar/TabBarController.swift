//
//  TabBarController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class TabBarController: UITabBarController, Coordinating {
    
    var finishFlow: boolClosure?
    var performEvent: performMainCoordinatorEvent?
    
    private var module = TabBarModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let lessonsNavigationController = createNavigationController(self.setupLessonsViewController())
        
        let giftsViewController = createNavigationController(
            module.createGiftsViewController(title: "Подарки", image: UIImage(systemName: "gift"))
        )
        let profileViewController = createNavigationController(
            module.createProfileViewController(title: "Профиль", image: UIImage(systemName: "person"))
        )
        
        viewControllers = [lessonsNavigationController, giftsViewController, profileViewController]
    }
    
    func setupLessonsViewController() -> LessonsViewController {
        let lessonsViewController = module.createLessonsViewController(title: "Занятия", image: UIImage(systemName: "books.vertical"))
        lessonsViewController.openDescription = {[weak self] id in
            self?.performEvent?(.showDescription(taskId: id))
        }
        return lessonsViewController
    }
    
    private func createNavigationController(_ vc: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        return navigationController
    }
}
