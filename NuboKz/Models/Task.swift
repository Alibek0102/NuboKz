//
//  Task.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import Foundation

struct Task {
    var name: String
    var taskId: String
    var level: String
    var bonus: Int
    
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String,
                let taskId = data["task_id"] as? String,
                let level = data["level"] as? String,
                let bonus = data["bonus"] as? Int
        else { return nil }
        
        self.name = name
        self.taskId = taskId
        self.level = level
        self.bonus = bonus
    }
}
