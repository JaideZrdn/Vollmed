//
//  SignUpViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    let service = VollmedService()
    
    func signUp() async -> Bool {
        
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: healthPlan)
        let response = await service.registerPatient(patient: patient)
        
        switch response {
        case .loaded:
            return true
        default:
            return false
        }
        
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var cpf: String = ""
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var healthPlan: String = "Amil"
    
    let healthPlans: [String] = [
    "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "São Francisco Saúde", "Golden Cross", "Medial Saúde", "América Saúde", "Outro"
    ]
    
}
