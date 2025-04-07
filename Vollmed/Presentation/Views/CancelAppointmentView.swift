//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 04/04/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    @State private var reasonToCancel: String = ""
    var appointmentID: String
    let service = WebService()
    
    @Environment(\.dismiss) var dismiss
    
    @State var showAlert: Bool = false
    @State var isAppointmentCancelled: Bool = false
    
    func cancelAppointment() async {
        
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                isAppointmentCancelled = true
            } else {
                isAppointmentCancelled = false
            }
        } catch {
            isAppointmentCancelled = false
            print(error.localizedDescription)
        }
        
        showAlert = true
        
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .foregroundStyle(.accent)
                .cornerRadius(16)
                .frame(maxHeight: 300)
            
            Button {
                Task {
                    await cancelAppointment()
                }
            } label: {
                ButtonView(text: "Caceelar Consulta", buttonType: .cancel)
            }
        }
        .padding()
        .navigationTitle("Cancelar Consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(isAppointmentCancelled ? "Consulta cancelada com sucesso!" : "Erro ao cancelar a consulta", isPresented: $showAlert, presenting: isAppointmentCancelled) { isCanceled in
            
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
