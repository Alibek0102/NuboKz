//
//  FirebaseManager.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 27.02.2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let db = Firestore.firestore()
    
    private init() {}
    
    func signIn(user: User, completionHandler: @escaping (Result<Bool, AuthError>) -> ()){
        Auth.auth().signIn(withEmail: user.email ?? "", password: user.password ?? "") { result, error in
            if error != nil {
                completionHandler(.failure(.userNotFound(text: "Пользователь не найден")))
                return
            }
            
            guard let userId = result?.user.uid else {
                completionHandler(.failure(.userNotFound(text: "Пользователь не найден")))
                return
            }
            
            let collectionName = "students"
            let collRef = self.db.collection(collectionName)
            
            collRef.whereField("student_id", isEqualTo: String(userId)).getDocuments { snapshot, error in
                if error != nil {
                    completionHandler(.failure(.userNotFound(text: "Пользователь не найден")))
                    return
                }
                
                var signedUser: SignedUser?
                
                for document in snapshot!.documents {
                    signedUser = SignedUser(data: document.data())
                }
                
                UserDefaultsManager.shared.setUserName(value: signedUser?.fullName ?? "")
                UserDefaultsManager.shared.setUserId(value: signedUser?.studentId ?? "")
                
                completionHandler(.success(true))
            }
        }
    }
}
