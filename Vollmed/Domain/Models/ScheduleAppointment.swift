//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Jaide Zardin on 03/04/25.
//

import Foundation

struct ScheduleAppointmentRequest: Codable {
    
    let specialist: String
    let pacient: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case specialist = "especialista"
        case pacient = "paciente"
        case date = "data"
    }
    
}

struct ScheduleAppointmentResponse: Codable, Identifiable {
    
    let id: String
    let specialist: String
    let pacient: String
    let date: String
    let reasonToCancel: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case specialist = "especialista"
        case pacient = "paciente"
        case date = "data"
        case reasonToCancel = "motivoCancelamento"
    }
    
}
