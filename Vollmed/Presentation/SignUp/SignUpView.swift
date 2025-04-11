//
//  SignUpView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
                    .scrollIndicators(.hidden)
                
                Text("Olá, boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Insira seus dados para criar uma conta")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                CustomInputTextField(title: "Insira seu nome completo", text: $viewModel.name)
                    .autocorrectionDisabled()
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                CustomInputTextField(title: "Insira seu email", keyboardType: .emailAddress, isSecureTextEntry: false, text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                CustomInputTextField(title: "Insira seu CPF", keyboardType: .numberPad, isSecureTextEntry: false, text: $viewModel.cpf)
                
                Text("Telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                CustomInputTextField(title: "Insira seu telefone", keyboardType: .numberPad, isSecureTextEntry: false, text: $viewModel.phoneNumber)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                CustomInputTextField(title: "Insira sua senha", isSecureTextEntry: true, text: $viewModel.password)
                
                Text("Selecione o seu plano de saúde")
                    .bold()
                    .font(.title3)
                    .foregroundStyle(.accent)
                
                Picker("Plano de Saúde", selection: $viewModel.healthPlan) {
                    ForEach(viewModel.healthPlans, id: \.self) { plan in
                        Text(plan)
                    }
                }
                    
                
                Button {
                    Task {
                        await viewModel.signUp()
                    }
                } label: {
                    ButtonView(text: "Cadastrar")
                }
                
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Já possui uma conta? Faça o login!")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert(viewModel.isPatientRegistered ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $viewModel.showAlert) {
            Button("OK") {
                if viewModel.isPatientRegistered {
                    viewModel.navigateToSignInView = true
                }
            }
        } message: {
            Text(viewModel.alertMessage)
        }
        .navigationDestination(isPresented: $viewModel.navigateToSignInView) {
            SignInView()
        }
    }
}

#Preview {
    SignUpView()
}
