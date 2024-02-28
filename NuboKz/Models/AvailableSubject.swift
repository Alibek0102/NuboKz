//
//  AvailableSubject.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit

class AvailableSubject {
    var userId: String
    var subjectId: String?
    
    init?(data: [String: Any]) {
        guard let userId = data["user_id"] as? String, let subjectId = data["subject_id"] as? String else { return nil }
        self.userId = userId
        self.subjectId = subjectId
    }
}
