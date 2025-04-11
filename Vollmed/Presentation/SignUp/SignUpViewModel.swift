//
//  SignUpViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    let service = VollmedService()
    
    func signUp() async  {
        
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: healthPlan)
        let response = await service.registerPatient(patient: patient)
        
        Task { @MainActor in
            switch response {
            case .loaded:
                isPatientRegistered = true
                alertMessage = "Cadastro realizado com sucesso!"
            case .error(let error):
                
                if let apiError = error as? APIError {
                    alertMessage = apiError.errorDescription ?? "Erro desconhecido."
                } else {
                    alertMessage = error.localizedDescription
                }
                
                isPatientRegistered = false
            case .loading:
                isPatientRegistered = false
                alertMessage = "Tempo de espera excedido. Por favor, tente novamente mais tarde."
            }
            showAlert = true
        }
    }
    
    @Published var showAlert: Bool = false
    @Published var isPatientRegistered: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var cpf: String = ""
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var healthPlan: String = "Amil"
    
    var alertMessage: String = ""
    
    @Published var navigateToSignInView: Bool = false
    
    let healthPlans: [String] = [
    "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "São Francisco Saúde", "Golden Cross", "Medial Saúde", "América Saúde", "Outro"
    ]
    
}
