//
//  SignInViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    let service = VollmedService()
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    
    func login() async -> LoginResponse? {
        
        let loginRequest = LoginRequest(email: email, password: password)
        let response = await service.login(loginRequest: loginRequest)
        
        return await MainActor.run {
            
            switch response {
            case .error:
                showAlert = true
                return nil
            case .loaded(let response):
                return response
            case .loading:
                showAlert = true
                return nil
            }
            
        }
    }
}
