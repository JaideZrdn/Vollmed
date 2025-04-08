//
//  AsyncView.swift
//  Vollmed
//
//  Created by Jaide Zardin on 07/04/25.
//

import SwiftUI

struct AsyncView<T, LoadedView: View>: View {
    
    let asyncData: AsyncData<T>
    let laodedView: (T) -> LoadedView
    
    var body: some View {
        switch asyncData {
        case .loading:
            ProgressView()
        case .error(let error):
            Text("Error: \(error)")
        case .loaded(let data):
            laodedView(data)
        }
    }
    
}
