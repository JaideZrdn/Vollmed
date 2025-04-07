//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 03/04/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @Environment(\.dismiss) var dismiss // Da dismiss na view atual que está sendo apresentada (seja um modal, uma TabView ou qualquer outra coisa)
    
    
    @State private var selectedDate: Date = Date()
    let service = WebService()
    var specialistID: String
    var isRescheduledView: Bool
    var appointmentID: String?
    
    @State private var showAlert: Bool = false
    @State private var isAppointmentScheduled: Bool = false
    
    init(specialistID: String, isRescheduledView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduledView = isRescheduledView
        self.appointmentID = appointmentID
    }
    
    func rescheduleAppointment() async {
        
        guard let appointmentID else {
            print("Houve um erro ao obter o id da consulta")
            return
        }
        
        do {
            
            if let _ = try await service.rescheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
                
                
            } else {
                isAppointmentScheduled = false
            }
            
        } catch {
            print(error.localizedDescription)
            isAppointmentScheduled = false
        }
        
        showAlert = true
    }
    
    func scheduleAppointment() async {
        do {
            
            if let _ = try await service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
    
                isAppointmentScheduled = true
            
            } else {
                isAppointmentScheduled = false
            }
            
        } catch {
            isAppointmentScheduled = false
            print(error.localizedDescription)
        }
        
        showAlert = true
        
    }
    
    var body: some View {
        
        VStack {
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(Color(.accent))
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: .init(.now) as PartialRangeFrom)
                .datePickerStyle(.graphical)
            
            
            Button {
                Task {
                    if isRescheduledView {
                        await rescheduleAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                }
            } label: {
                ButtonView(text: isRescheduledView ? "Reagendar Consulta" : "Agendar Consuta")
            }
        }
        .padding()
        .navigationTitle(isRescheduledView ? "Reagendar Consulta" : "Agendar Consuta")
        .navigationBarTitleDisplayMode(.automatic)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentScheduled) { isScheduled in
            
            Button {
                if isScheduled {
                    dismiss()
                }
                
            } label: {
                Text("Ok")
            }
            
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi \(isRescheduledView ? "reagendada" : "agendada") com sucesso")
            } else {
                Text("Não foi possível \(isRescheduledView ? "reagendar" : "agendar") a consulta. Tente novamente mais tarde.")
            }
        }

        
    }
}

#Preview {
    NavigationStack {
        ScheduleAppointmentView(specialistID: "12093")
    }
}
