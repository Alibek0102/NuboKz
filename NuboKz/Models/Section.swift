//
//  Section.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import UIKit

struct Section {
    var name: String
    var createdAt: Date
    var sectionId: String
    
    init(name: String, createdAt: Date, sectionId: String) {
        self.name = name
        self.createdAt = createdAt
        self.sectionId = sectionId
    }
}
