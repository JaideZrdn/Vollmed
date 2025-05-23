//
//  APIs.swift
//  Vollmed
//
//  Created by Jaide Zardin on 07/04/25.
//

import Foundation

public enum APIs { }

extension APIs {
    
    enum Vollmed: APIEndpoint {
        
        static var baseURL: URL = URL(string: "http://localhost:3000")!
        
        var path: String {
            
            switch self {
            case .getAllSpecialists:
                return "especialista"
            case .downloadImage(let path):
                return path
            case .getAllAppointmentsFrom(let id):
                return "paciente/\(id)/consultas"
            case .scheduleAppointment:
                return "consulta"
            case .rescheduleAppointment(let appointmentID, _):
                return "consulta/\(appointmentID)"
            case .cancelAppointment(let appointmentID, _):
                return "consulta/\(appointmentID)"
            case .register:
                return "paciente"
            case .login:
                return "auth/login"
            case .logout:
                return "auth/logout"
            }
            
        }
        
        var method: HTTPMethod {
            
            switch self {
            case .getAllAppointmentsFrom, .getAllSpecialists, .downloadImage:
                return .get
            case .scheduleAppointment, .register, .login, .logout:
                return .post
            case .rescheduleAppointment:
                return .patch
            case .cancelAppointment:
                return .delete
            }
        }
        
        var headers: [String : String]? {
            
            switch self {
            case .register, .login:
                return ["Content-Type": "application/json"]
            case .scheduleAppointment, .rescheduleAppointment, .cancelAppointment:
                if let token = KeyChainHelper.get(for: "app-vollmed-token") {
                    print(token)
                    return ["Content-Type": "application/json", "Authorization" : "Bearer \(token)"]
                } else {
                    return nil
                }
            case .getAllAppointmentsFrom, .logout:
                if let token = KeyChainHelper.get(for: "app-vollmed-token") {
                    return ["Authorization" : "Bearer \(token)"]
                } else {
                    return nil
                }
            default:
                return nil
            }
            
        }
        
        var parameters: [String : Any]? { return nil }
        
        var body: Data? {
            
            switch self {
            case .cancelAppointment(_, let reasonToCancel):
                let requestData = ["motivoCancelamento": reasonToCancel]
                return try? JSONSerialization.data(withJSONObject: requestData)
            case .scheduleAppointment(scheduleAppointmentRequest: let request):
                return try? JSONEncoder().encode(request)
            case .rescheduleAppointment(_, let newDate):
                let requestData = ["data": newDate]
                return try? JSONSerialization.data(withJSONObject: requestData)
            case .register(patient: let patient):
                return try? JSONEncoder().encode(patient)
            case .login(loginRequest: let request):
                return try? JSONEncoder().encode(request)
            default:
                return nil
            }
        }
        
        case getAllSpecialists
        case downloadImage(imageURL: String)
        case getAllAppointmentsFrom(patientID: String)
        case scheduleAppointment(scheduleAppointmentRequest: ScheduleAppointmentRequest)
        case rescheduleAppointment(appointmentID: String, date: String)
        case cancelAppointment(appointmentID: String, reasonToCancel: String)
        case register(patient: Patient)
        case login(loginRequest: LoginRequest)
        case logout
    }
}


