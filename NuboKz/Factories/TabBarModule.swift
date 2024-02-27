//
//  TabBarItems.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

class TabBarModule {
    
    func createLessonsViewController(title: String, image: UIImage!) -> LessonsViewController {
        let viewController = LessonsViewController()
        let presenter = LessonsPresenter(viewController: viewController)
        viewController.presenter = presenter
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func createGiftsViewController(title: String, image: UIImage!) -> GiftsViewController {
        let viewController = GiftsViewController()
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    func createProfileViewController(title: String, image: UIImage!) -> ProfileViewController {
        let viewController = ProfileViewController()
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
}
