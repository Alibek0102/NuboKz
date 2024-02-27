//
//  FirebaseManager.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    private init() {}
    
    func getAllSubjects(completionHandler: @escaping (Result<[Subject], NetworkError>) -> ()) {
        let collectionName = "subjects"
        let collectionRef = db.collection(collectionName)
        
        collectionRef.getDocuments { snapshot, error in
            if let error = error {
                completionHandler(.failure(.networkError(text: "Плохой интернет")))
                return
            }
            
            var allSubjects: [Subject] = []
            
            for document in snapshot!.documents {
                guard let subject = Subject(data: document.data()) else {
                    completionHandler(.failure(.incorrectData(text: "При получений данных произошла ошибка")))
                    return
                }
                
                allSubjects.append(subject)
            }
            
            completionHandler(.success(allSubjects))
        }
    }
}
