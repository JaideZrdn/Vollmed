//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 04/04/25.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = VollmedService()
    @State private var appointments: AsyncData<[Appointment]> = .loading
    
    func getAllAppointments() async {
        appointments = await service.getAllAppointments(from: patientID)
    }
    
    var body: some View {
        VStack {
            ScrollView {
                AsyncView(asyncData: appointments) { appointments in
                    ForEach(appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    }
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
