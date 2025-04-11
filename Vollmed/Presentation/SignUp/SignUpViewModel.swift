//
//  SignUpViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var cpf: String = ""
    @Published var name: String = ""
    @Published var phoneNumber: String = ""
    @Published var healthPlan: String = ""
    
}
