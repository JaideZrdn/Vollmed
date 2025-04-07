//
//  AsyncData.swift
//  Vollmed
//
//  Created by Jaide Zardin on 07/04/25.
//

import Foundation

public enum AsyncData<T> {
    
    case loading
    case error(any Error)
    case loaded(T)
    
}
