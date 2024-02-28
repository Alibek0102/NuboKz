//
//  UserDefaultsManager.swift
//  NuboKz
//
//  Created by Алибек Аблайулы on 28.02.2024.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    enum UserDefaultsKeys: String {
        case username = "username"
        case userId = "userId"
    }
    
    func setUserName(value: String) {
        UserDefaults.standard.setValue(value, forKey: "username")
    }
    
    func getUserName() -> String? {
        return UserDefaults.standard.string(forKey: "username")
    }
    
    func setUserId(value: String) {
        UserDefaults.standard.setValue(value, forKey: "userId")
    }
    
    func getUserId() -> String? {
        return UserDefaults.standard.string(forKey: "userId")
    }
    
    func resetUserDefaults() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "userId")
    }
}

