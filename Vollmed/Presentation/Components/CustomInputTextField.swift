//
//  CustomInputTextField.swift
//  Vollmed
//
//  Created by Jaide Zardin on 11/04/25.
//

import SwiftUI

struct CustomInputTextField: View {
    
    var isSecureTextEntry: Bool = false
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    init(title: String, keyboardType: UIKeyboardType = .default, isSecureTextEntry: Bool = false, text: Binding<String>) {
        self.title = title
        self.keyboardType = keyboardType
        self.isSecureTextEntry = isSecureTextEntry
        self._text = text
    }
    
    var body: some View {
        
        textInputGenerator()
            .padding(14)
            .background(Color.gray.opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .keyboardType(keyboardType)
        
    }
    
    @ViewBuilder
    private func textInputGenerator() -> some View {
        if isSecureTextEntry {
             SecureField(title, text: $text)
        } else {
             TextField(title, text: $text)
        }
    }
    
}
