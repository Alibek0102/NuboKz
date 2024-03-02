//
//  ListIds.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import Foundation

enum ListIds: String {
    case stories = "storiesListId"
    case lessonItem = "lessonItem"
    case missionsItem = "missionsItem"
    
    func getId() -> String{
        return self.rawValue
    }
}
