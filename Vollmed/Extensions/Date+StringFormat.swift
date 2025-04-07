//
//  Date+StringFormat.swift
//  Vollmed
//
//  Created by Jaide Zardin on 03/04/25.
//

import Foundation

extension Date {
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" //Z é o deslocamento do fuso
        return dateFormatter.string(from: self)
    }
    
}
