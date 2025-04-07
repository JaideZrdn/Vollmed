//
//  String+Readable.swift
//  Vollmed
//
//  Created by Jaide Zardin on 03/04/25.
//

import Foundation

extension String {
    
    func convertDateStringToReadableDate() -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputFormatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy' às 'HH:mm" //Aspas simples para colocar texto junto
            return dateFormatter.string(from: date)
        } else {
            return ""
        }
    }
}
