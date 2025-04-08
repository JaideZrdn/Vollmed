//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 03/04/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @Environment(\.dismiss) var dismiss // Da dismiss na view atual que está sendo apresentada (seja um modal, uma TabView ou qualquer outra coisa)
    @StateObject var scheduleAppointmentViewModel: ScheduleAppointmentViewModel = .init()
    
    var specialistID: String
    var isRescheduledView: Bool
    var appointmentID: String?
    
    init(specialistID: String, isRescheduledView: Bool = false, appointmentID: String? = nil) {
        self.specialistID = specialistID
        self.isRescheduledView = isRescheduledView
        self.appointmentID = appointmentID
    }
    
    var body: some View {
        
        VStack {
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(Color(.accent))
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $scheduleAppointmentViewModel.selectedDate, in: .init(.now) as PartialRangeFrom)
                .datePickerStyle(.graphical)
            
            Button {
                Task {
                    if isRescheduledView {
                        await scheduleAppointmentViewModel.rescheduleAppointment(appointmentID: appointmentID)
                    } else {
                        await scheduleAppointmentViewModel.scheduleAppointment(specialistID: specialistID)
                    }
                }
            } label: {
                ButtonView(text: isRescheduledView ? "Reagendar Consulta" : "Agendar Consuta")
            }
        }
        .padding()
        .navigationTitle(isRescheduledView ? "Reagendar Consulta" : "Agendar Consuta")
        .navigationBarTitleDisplayMode(.automatic)
//        .onAppear {
//            UIDatePicker.appearance().minuteInterval = 15
//        }
        .alert(scheduleAppointmentViewModel.isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado", isPresented: $scheduleAppointmentViewModel.showAlert, presenting: scheduleAppointmentViewModel.isAppointmentScheduled) { isScheduled in
            
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
