//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Jaide Zardin on 08/04/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    let service = VollmedService()
    @Published var specialists: AsyncData<[Specialist]> = .loading
    
    func getSpecialists() async {
        Task { @MainActor in
            specialists = await service.fetchAllSpecialists()
        }
    }
}
