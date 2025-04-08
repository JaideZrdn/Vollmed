//
//  ContentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
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

#Preview {
    ContentView()
}
