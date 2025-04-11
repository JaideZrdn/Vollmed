//
//  ContentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var authManager = AuthenticationManager.shared
    
    var body: some View {
        
        if authManager.token == nil {
            NavigationStack {
                SignInView()
            }
        } else {
            
            TabView {
                
                Tab {
                    NavigationStack {
                        HomeView()
                    }
                } label: {
                    Label("Home", systemImage: "house")
                }
                
                Tab {
                    NavigationStack {
                        MyAppointmentsView()
                    }
                } label: {
                    Label("Minhas consultas", systemImage: "calendar")
                }
                
                
            }
        }
        
    }
}

#Preview {
    ContentView()
}
