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
                
                let section = Section(name: data["name"] as! String, createdAt: date, sectionId: data["section_id"] as! String)
                
                sections.append(section)
            }
            
            completionHandler(.success(sections))
        }
    }
    
    func getTasksBySectionId(sectionId: String?, comletionHandler: @escaping(Result<[Task], NetworkError>) -> ()){
        let collectionName = "tasks"
        let collectionRef = db.collection(collectionName)
        
        guard let sectionId = sectionId else {
            comletionHandler(.failure(.incorrectData(text: "Ошибка при получений Section Id")))
            return
        }
        
        collectionRef.whereField("section_id", isEqualTo: sectionId).getDocuments { snapshot, error in
            if error != nil {
                comletionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
                return
            }
            
            var tasks: [Task] = []
            
            for document in snapshot!.documents {
                if let data = Task(data: document.data()) {
                    tasks.append(data)
                }
            }
            
            comletionHandler(.success(tasks))
        }
    }
    
    func getTaskDescription(taskId: String?, completionHandler: @escaping (Result<TaskDescription, NetworkError>) -> ()) {
        guard let taskId = taskId else {
            completionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
            return
        }
        
        let collectionName = "taskDescription"
        let collectionRef = db.collection(collectionName)
        
        collectionRef.whereField("task_id", isEqualTo: taskId).getDocuments { snapshot, error in
            if error != nil {
                completionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
                return
            }
            
            if snapshot!.documents.count == 0 {
                completionHandler(.failure(.incorrectData(text: "Description отсутствует")))
                return
            }
            
            let data = snapshot!.documents[0].data()
            
            let taskDescription = TaskDescription(data: data)
            
            if let taskDescription = taskDescription {
                completionHandler(.success(taskDescription))
            } else {
                completionHandler(.failure(.incorrectData(text: "Description отсутствует")))
            }
        }
    }
    
    func getMissionsByTaskId(taskId: String?, completionHandler: @escaping (Result<[Mission], NetworkError>) -> ()) {
        let collectionName = "missions"
        let collectionRef = db.collection(collectionName)
        
        guard let taskId = taskId else { 
            completionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
            return
        }
        
        let query = collectionRef.order(by: "step", descending: true)
        
        query.whereField("task_id", isEqualTo: taskId).getDocuments { snapshot, error in
            if error != nil {
                completionHandler(.failure(.incorrectData(text: "Ошибка при получений данных")))
                return
            }
            
            var missions: [Mission] = []
            
            for document in snapshot!.documents {
                let data = document.data()
                
                if let missionType = data["missionType"] as? Int,
                   let missionId = data["mission_id"] as? String,
                   let step = data["step"] as? Int,
                   let text = data["text"] as? String
                {
                    if missionType == 1 {
                        let testData = Mission.test(step: step, missionId: missionId, text: text)
                        missions.append(testData)
                    }
                    
                }
            }
            
            completionHandler(.success(missions))
        }
    }
}
