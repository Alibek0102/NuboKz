//
//  Subject.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import Foundation

struct Subject {
    var name: String
    var subject_id: Int
    var teacher: String
    
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String, let subject_id = data["subject_id"] as? Int, let teacher = data["teacher"] as? String else { return nil }
        
        self.name = name
        self.subject_id = subject_id
        self.teacher = teacher
    }
}
