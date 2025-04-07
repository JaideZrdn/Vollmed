//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 04/04/25.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        
        do {
            
            if let appointment = try await service.getAllAppointments(from: patientID) {
                self.appointments = appointment
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    var body: some View {
        VStack {
            ScrollView {
                
                ForEach(appointments) { appointment in
                    
                    SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    
                }
                
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Minhas Consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
