//
//  FirebaseLessonsManager.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import UIKit
import FirebaseFirestore

class FirebaseLessonsManager {
    static let shared = FirebaseLessonsManager()
    
    let db = Firestore.firestore()
    
    private init() {}
    
    func getSubjectIds(userId: String,completionHandler: @escaping (Result<[String], NetworkError>) -> ()) {
        let collectionName = "availableSubjects"
        let collectionRef = db.collection(collectionName)
        
        collectionRef.whereField("user_id", isEqualTo: String(userId)).getDocuments { snapshot, error in
            if(error != nil) {
                return
            }
            
            var availableSubjects: [String] = []
            
            for document in snapshot!.documents {
                let data = document.data()
                
                if let subjectId = data["subject_id"] as? String {
                    availableSubjects.append(subjectId)
                }
            }
            
            completionHandler(.success(availableSubjects))
        }
    }
    
    
    func getAllSubjects(userId: String?, completionHandler: @escaping (Result<[Subject], NetworkError>) -> ()) {
        let collectionName = "subjects"
        let collectionRef = db.collection(collectionName)
        
        guard let userId = userId else { return }
        
        getSubjectIds(userId: userId) { responce in
            switch responce {
            case .success(let ids):
                collectionRef.whereField("subject_id", in: ids).getDocuments { snapshot, error in
                    if error != nil {
                        completionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
                        return
                    }
                    
                    var subjects: [Subject] = []
                    
                    for document in snapshot!.documents {
                        if let subject = Subject(data: document.data()) {
                            subjects.append(subject)
                        }
                    }
                    
                    completionHandler(.success(subjects))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getSectionsOfSubjectBySegment(subject: Subject, completionHandler: @escaping (Result<[Section], NetworkError>) -> ()){
        let collectionName = "subjectSections"
        let collectionRef = db.collection(collectionName)
        
        collectionRef.whereField("subject_id", isEqualTo: subject.subject_id).getDocuments { snapshot, error in
            if error != nil {
                completionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
                return
            }
            
            var sections: [Section] = []
            
            for document in snapshot!.documents {
                let data = document.data()
                
                let firebaseTimestamp: Timestamp = data["created_at"] as! Timestamp
                let date = firebaseTimestamp.dateValue()
                
                let section = Section(name: data["name"] as! String, createdAt: date)
                
                sections.append(section)
            }
            
            completionHandler(.success(sections))
        }
    }
}
