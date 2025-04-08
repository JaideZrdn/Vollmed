//
//  CancelAppointmentViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 08/04/25.
//

import SwiftUI

class CancelAppointmentViewModel: ObservableObject {
    
    let service = VollmedService()
    
    @Published var reasonToCancel: String = ""
    @Published var showAlert: Bool = false
    @Published var isAppointmentCancelled: Bool = false
    
    func cancelAppointment(appointmentID: String) async {
        
        let response = await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel)
        
        await MainActor.run {
            
            switch response {
            case .error:
                isAppointmentCancelled = false
            default:
                isAppointmentCancelled = true
                showAlert = true
            
            }
        }
        
    }
    
}
