//
//  Types.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 26.02.2024.
//

import Foundation

enum MainCoordinatorEvents {
    case showDescription(taskId: String?)
}

enum MissionCoordinatorEvents {
    case missionsViewController
}

typealias boolClosure = (Bool) -> ()
typealias stringClosure = (String) -> ()
typealias performMainCoordinatorEvent = (MainCoordinatorEvents) -> ()
typealias performMissionCoordinatorEvents = (MissionCoordinatorEvents) -> ()
