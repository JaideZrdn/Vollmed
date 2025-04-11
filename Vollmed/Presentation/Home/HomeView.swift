//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel: HomeViewModel = .init()
    var authManager = AuthenticationManager.shared
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                
                AsyncView(asyncData: homeViewModel.specialists) { specialists in
                    ForEach(specialists) { specialist in
                        SpecialistCardView(specialist: specialist)
                            .padding(.bottom, 8)
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            Task {
                await homeViewModel.getSpecialists()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        if let response = await homeViewModel.logoutPatient() {
                            authManager.removeToken()
                            authManager.removePatientID()
                        }
                    }
                } label: {
                    HStack(spacing: 2) {
                        
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
