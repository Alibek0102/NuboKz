//
//  FirebaseStoriesManager.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 29.02.2024.
//

import UIKit
import FirebaseFirestore

class FirebaseStoriesManager {
    static let shared = FirebaseStoriesManager()
    
    let db = Firestore.firestore()
    
    private init() {}
    
    func getStories(completionHanler: @escaping (Result<[Story], NetworkError>) -> ()) {
        let collectionName = "stories"
        let collectionRef = db.collection(collectionName)
        
        collectionRef.getDocuments { snapshot, error in
            if error != nil {
                completionHanler(.failure(.networkError(text: "Неудалось получить данные")))
                return
            }
            
            var stories: [Story] = []
            
            for document in snapshot!.documents {
                if let story = Story(data: document.data()) {
                    stories.append(story)
                }
            }
            
            completionHanler(.success(stories))
        }
    }
}
