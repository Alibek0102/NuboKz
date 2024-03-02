//
//  TaskDescription.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 01.03.2024.
//

import UIKit

struct TaskDescription {
    var title: String
    var text: String
    var taskId: String
    var image: String
    
    init?(data: [String: Any]) {
        guard let title = data["title"] as? String, let text = data["text"] as? String, let taskId = data["task_id"] as? String, let image = data["image"] as? String else { return nil }
        self.title = title
        self.text = text
        self.taskId = taskId
        self.image = image
    }
}
