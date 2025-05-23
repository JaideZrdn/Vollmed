//
//  SignInView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 08/04/25.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    var authManager = AuthenticationManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
            
            Text("Olá!")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            
            Text("Preencha para acessar sua conta")
                .font(.title3)
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            Text("Email")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            CustomInputTextField(title: "Insira seu email", keyboardType: .emailAddress, isSecureTextEntry: false, text: $viewModel.email)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            Text("Senha")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            CustomInputTextField(title: "Insira sua senha", isSecureTextEntry: true, text: $viewModel.password)

            Button {
                Task {
                    if let response = await viewModel.login() {
                        authManager.saveToken(response.token)
                        authManager.savePatientID(response.id)
                    }
                }
            } label: {
                ButtonView(text: "Entrar")
            }
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert("Ops, algo deu errado!", isPresented: $viewModel.showAlert) {
            Button("Ok") {
                
            }
        } message: {
            Text("Houve um erro ao entrar na sua conta")
        }

    }
}

#Preview("Perview de Login") {
    SignInView()
}
