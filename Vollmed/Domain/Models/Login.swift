//
//  Login.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

struct LoginRequest: Codable {
    
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
    
}

struct LoginResponse: Codable, Identifiable {
    
    let auth: Bool
    let id: String
    let token: String
    
}
