//
//  SignUp.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

struct Patient: Codable, Identifiable {
    
    let id: String?
    let cpf: String
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let healthPlan: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case cpf
        case name = "nome"
        case email
        case password = "senha"
        case phoneNumber = "telefone"
        case healthPlan = "planoSaude"
    }
}
