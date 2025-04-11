//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

class AuthenticationManager: ObservableObject {
    
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientID: String?
    
    private init() {
        
        self.token = KeyChainHelper.get(for: "app-vollmed-token")
        self.patientID = KeyChainHelper.get(for: "app-vollmed-patient-id")
        
    }
    
    func saveToken(_ token: String) {
        
        KeyChainHelper.save(key: "app-vollmed-token", value: token)
        self.token = token
    }
    
    func removeToken() {
        KeyChainHelper.remove(for: "app-vollmed-token")
        self.token = nil
    }
    
    func savePatientID(_ patientID: String) {
        KeyChainHelper.save(key: "app-vollmed-patient-id", value: patientID)
        self.patientID = patientID
    }
    
    func removePatientID() {
        KeyChainHelper.remove(for: "app-vollmed-patient-id")
        self.patientID = nil
    }
}

