//
//  APIClient.swift
//  Vollmed
//
//  Created by Jaide Zardin on 07/04/25.
//

import Foundation

protocol APIClient {
    
    associatedtype Endpoint: APIEndpoint
    func request<T: Decodable>(_ endpoint: Endpoint) async -> AsyncData<T>
    
}

class URLSessionAPIClient<Endpoint: APIEndpoint>: APIClient {
    
    func request<T>(_ endpoint: Endpoint) async -> AsyncData<T> where T : Decodable {
        
        let url = endpoint.url
        var request = URLRequest(url: url)
        
        do {
            endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
            request.httpBody = endpoint.body
            request.httpMethod = endpoint.method.rawValue
            
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
                return .error(APIError.nonHTTPResponse)
            }
            
            guard (200...299).contains(httpURLResponse.statusCode) else {
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    return .error(APIError.serverError(errorResponse.error))
                } else {
                    return .error(APIError.invalidStatusCode(httpURLResponse.statusCode))
                }
            }
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .loaded(decodedData)
            
        } catch let urlError as URLError {
            return .error(APIError.networkError(urlError.localizedDescription))
        } catch {
            return .error(APIError.unknownError)
        }
    }
}
