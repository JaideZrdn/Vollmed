//
//  UserDefaultsHelper.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import Foundation

struct UserDefaultsHelper {
    
    static func save(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(for key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    static func remove(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
