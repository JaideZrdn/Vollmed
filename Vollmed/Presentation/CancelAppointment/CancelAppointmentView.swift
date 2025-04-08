//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 04/04/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    var appointmentID: String
    @StateObject var cancelAppointmentViewModel: CancelAppointmentViewModel = .init()
    
    @Environment(\.dismiss) var dismiss
    
        
        var body: some View {
            VStack(spacing: 16) {
                Text("Conte-nos o motivo do cancelamento da sua consulta")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                    .padding(.top)
                    .multilineTextAlignment(.center)
                
                TextEditor(text: $cancelAppointmentViewModel.reasonToCancel)
                    .padding()
                    .font(.title3)
                    .scrollContentBackground(.hidden)
                    .background(Color(.lightBlue).opacity(0.15))
                    .foregroundStyle(.accent)
                    .cornerRadius(16)
                    .frame(maxHeight: 300)
                
                Button {
                    Task {
                        await cancelAppointmentViewModel.cancelAppointment(appointmentID: appointmentID)
                    }
                } label: {
                    ButtonView(text: "Cancelar Consulta", buttonType: .cancel)
                }
            }
            .padding()
            .navigationTitle("Cancelar Consulta")
            .navigationBarTitleDisplayMode(.large)
            .alert(cancelAppointmentViewModel.isAppointmentCancelled ? "Consulta cancelada com sucesso!" : "Erro ao cancelar a consulta", isPresented: $cancelAppointmentViewModel.showAlert, presenting: cancelAppointmentViewModel.isAppointmentCancelled) { isCanceled in
                
                Button("Ok") {
                    if isCanceled {
                        dismiss()
                    }
                }
            } message: { isCanceled in
                if !isCanceled {
                    Text("A consulta não foi cancelada. Tente novamente mais tarde.")
                } else {
                    Text("A consulta foi cancelada com sucesso!")
                }
            }
        }
    }
    
    #Preview {
        CancelAppointmentView(appointmentID: "12313")
    }
