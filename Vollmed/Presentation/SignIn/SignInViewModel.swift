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
    
    func login() async {
        
        let loginRequest = LoginRequest(email: email, password: password)
        let response = await service.login(loginRequest: loginRequest)
        
        await MainActor.run {
            
            switch response {
            case .error(let error):
            case .loaded(let response):
            case .loading:
            }
            
        }
        
    }
    
}
