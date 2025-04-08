//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 04/04/25.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    @StateObject var myAppointmentsViewModel: MyAppointmentsViewModel = .init()
    
    var body: some View {
        VStack {
            ScrollView {
                AsyncView(asyncData: myAppointmentsViewModel.appointments) { appointments in
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
                await myAppointmentsViewModel.getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
