//
//  Stories.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import Foundation

struct Story {
    let storyId: String
    let image: String
    
    init?(data: [String: Any]) {
        guard let storyId = data["story_id"] as? String, let image = data["image"] as? String else { return nil }

        self.storyId = storyId
        self.image = image
    }
}
