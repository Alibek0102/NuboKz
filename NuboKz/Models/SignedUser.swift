//
//  SignedUser.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import Foundation

struct SignedUser {
    var email: String?
    var fullName: String?
    var studentId: String?
    
    init?(data: [String: Any]) {
        guard let email = data["email"] as? String, let fullName = data["fullName"] as? String, let studentId = data["student_id"] as? String else { return nil }
        
        self.email = email
        self.fullName = fullName
        self.studentId = studentId
    }
}
