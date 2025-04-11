//
//  ScheduleAppointmentViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 08/04/25.
//

import SwiftUI

class ScheduleAppointmentViewModel: ObservableObject {
    
    let service = VollmedService()
    
    @Published var selectedDate: Date = Date()
    @Published var isAppointmentScheduled: Bool = false
    @Published var showAlert: Bool = false
    
    func rescheduleAppointment(appointmentID: String?) async {
        
        guard let appointmentID else {
            return
        }
        
        let appointmentResponse = await service.rescheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString())
        
        await MainActor.run {
            switch appointmentResponse {
            case .error:
                isAppointmentScheduled = false
            default:
                isAppointmentScheduled = true
            }
            showAlert = true
        }
    }
    
    func scheduleAppointment(specialistID: String) async {
        
        if let id = UserDefaultsHelper.get(for: "patient-id") {
            
            let appointmentResponse = await service.scheduleAppointment(specialistID: specialistID, patientID: id, date: selectedDate.convertToString())
            
            
            await MainActor.run {
                switch appointmentResponse {
                case .error:
                    isAppointmentScheduled = false
                default:
                    isAppointmentScheduled = true
                }
                showAlert = true
            }
        }
        
    }
}
