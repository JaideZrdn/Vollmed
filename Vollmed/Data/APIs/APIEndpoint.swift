//
//  APIEndpoint.swift
//  Vollmed
//
//  Created by Jaide Zardin on 07/04/25.
//

import Foundation

protocol APIEndpoint {
    
    static var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var body: Data? { get }
    
}

extension APIEndpoint {
    var url: URL { Self.baseURL.appendingPathComponent(path) }
}


enum HTTPMethod: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum APIError: LocalizedError {
    case nonHTTPResponse
    case invalidStatusCode(Int)
    case invalidData
    case networkError(String)
    case unknownError

    var errorDescription: String? {
        switch self {
        case .nonHTTPResponse:
            return "A resposta recebida não é uma resposta HTTP válida."
        case .invalidStatusCode(let statusCode):
            return "Código de status inválido: \(statusCode)."
        case .invalidData:
            return "Os dados recebidos são inválidos."
        case .networkError(let message):
            return "Erro de rede: \(message)"
        case .unknownError:
            return "Ocorreu um erro desconhecido."
        }
    }
}
