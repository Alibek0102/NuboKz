//
//  TabBarController.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class TabBarController: UITabBarController, Coordinating {
    
    var finishFlow: boolClosure?
    
    private let module = TabBarModule()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let lessonsViewController = createNavigationController(
            module.createLessonsViewController(title: "Занятия", image: UIImage(systemName: "books.vertical"))
        )
        let giftsViewController = createNavigationController(
            module.createGiftsViewController(title: "Подарки", image: UIImage(systemName: "gift"))
        )
        let profileViewController = createNavigationController(
            module.createProfileViewController(title: "Профиль", image: UIImage(systemName: "person"))
        )
        
        viewControllers = [lessonsViewController, giftsViewController, profileViewController]
    }
    
    private func createNavigationController(_ vc: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: vc)
        return navigationController
    }
    
}
