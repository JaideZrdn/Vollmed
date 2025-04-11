//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import Foundation
import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
    let cache = NSCache<NSString, UIImage>()
    
    //FETCH
    func getAllSpecialists() async throws -> [Specialist]? {
        
        let endpoint = baseURL + "/especialista"
        
        guard let url = URL(string: endpoint) else {
            print("erro na URL")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        let specialist = try decoder.decode([Specialist].self, from: data)
        
        return specialist
        
    }
    
    //FETCH
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        
        guard let url = URL(string: imageURL) else {
            print("Error na URL")
            return nil
        }
        
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        cache.setObject(image, forKey: url.absoluteString as NSString)
        
        return image
    }
    
    //FETCH
    func getAllAppointments(from patientID: String) async throws -> [Appointment]? {
        
        let endpoint = baseURL + "/paciente/" + patientID + "/consultas"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        let appointment = try decoder.decode([Appointment].self, from: data)
        
        return appointment
        
    }
    
    //POST
    func scheduleAppointment(specialistID: String,
                             patientID: String,
                             date: String) async throws -> ScheduleAppointmentResponse? {
        
        let endpoint = baseURL + "/consulta" //Qual o endpoint referente ao post
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL")
            return nil
        }
        
        let appointment = ScheduleAppointmentRequest(specialist: specialistID, pacient: patientID, date: date) //Cria nossa schedule appointment request (formato das coisas é igual ao body do JSON)
        
        let jsonEncoder = JSONEncoder()
        
        let jsonData = try jsonEncoder.encode(appointment) //Transforma em JSON
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //Digo que o método é POST
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") //nome do que vai ficar no espaço do header e qual espaço do header vai
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request) //Resultado do meu post
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data) // Processa o decode pra ScheduleAppointmentResponse
        
        return appointmentResponse
    }
    
    
    //PATCH
    func rescheduleAppointment(appointmentID: String, date: String) async throws -> ScheduleAppointmentResponse? {
        
        let endpoint = baseURL + "/consulta/" + appointmentID
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL")
            return nil
        }
        
        let requestData: [String:String] = ["data": date]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
        
    }
    
    //DELETE
    func cancelAppointment(appointmentID: String, reasonToCancel: String) async throws -> Bool {
        
        let endpoint = baseURL + "/consulta/" + appointmentID
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL")
            return false
        }
        
        let requestData: [String:String] = ["motivoCancelamento" : reasonToCancel]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = jsonData
        
        let (_, httpResponse) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = httpResponse as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        } else {
            return false
        }
        
    }
}

