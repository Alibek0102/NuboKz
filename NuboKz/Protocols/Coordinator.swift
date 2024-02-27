//
//  Coordinator.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
}

protocol Coordinating: AnyObject {
    var finishFlow: boolClosure? { get set }
}

protocol AuthCoordinating: AnyObject {
    var finishFlow: stringClosure? { get set }
    
    func finish()
}
