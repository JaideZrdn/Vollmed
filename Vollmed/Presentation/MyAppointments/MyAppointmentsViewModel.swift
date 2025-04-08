//
//  MyAppointmentsViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 08/04/25.
//

import SwiftUI

class MyAppointmentsViewModel: ObservableObject {
    
    let service = VollmedService()
    @Published var appointments: AsyncData<[Appointment]> = .loading
    
    func getAllAppointments() async {
        Task { @MainActor in
            appointments = await service.getAllAppointments(from: patientID)
        }
    }
    
    
    
}
