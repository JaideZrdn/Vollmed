//
//  VollmedService.swift
//  Vollmed
//
//  Created by Jaide Zardin on 07/04/25.
//

import Foundation

class VollmedService {
    
    let apiClient = URLSessionAPIClient<APIs.Vollmed>()
    
    // Função para buscar todos os especialistas
    func fetchAllSpecialists() async -> AsyncData<[Specialist]> {
        let result: AsyncData<[Specialist]> = await apiClient.request(.getAllSpecialists)
        return result
    }
    
    // Função para buscar todas as consultas de um paciente
    func getAllAppointments(from patientID: String) async -> AsyncData<[Appointment]> {
        let result: AsyncData<[Appointment]> = await apiClient.request(.getAllAppointmentsFrom(patientID: patientID))
        return result
    }
    
    // Função para agendar uma consulta
    func scheduleAppointment(specialistID: String, patientID: String, date: String) async -> AsyncData<ScheduleAppointmentResponse> {
        let request = ScheduleAppointmentRequest(specialist: specialistID, pacient: patientID, date: date)
        let result: AsyncData<ScheduleAppointmentResponse> = await apiClient.request(.scheduleAppointment(scheduleAppointmentRequest: request))
        return result
    }
    
    // Função para reagendar uma consulta
    func rescheduleAppointment(appointmentID: String, date: String) async -> AsyncData<ScheduleAppointmentResponse> {
        let result: AsyncData<ScheduleAppointmentResponse> = await apiClient.request(.rescheduleAppointment(appointmentID: appointmentID, date: date))
        return result
    }
    
    // Função para cancelar uma consulta
    func cancelAppointment(appointmentID: String, reasonToCancel: String) async -> AsyncData<String> {
        let result: AsyncData<String> = await apiClient.request(.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel))
        return result
    }
}

