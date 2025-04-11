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
    
    func login() async {
        
        let loginRequest = LoginRequest(email: email, password: password)
        let response = await service.login(loginRequest: loginRequest)
        
        await MainActor.run {
            
            switch response {
            case .error:
                showAlert = true
            case .loaded(let response):
                
                UserDefaultsHelper.save(value: response.token, key: "token")
                UserDefaultsHelper.save(value: response.id, key: "patient-id")
                
                print(response.auth)
            case .loading:
                showAlert = true
            }
        }
    }
}
