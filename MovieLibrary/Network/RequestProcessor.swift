//
//  RequestProcessor.swift
//  MovieLibrary
//
//  Created by MACim on 27.05.2025.
//

import Foundation

protocol RequestProcessorProtocol {
    func request<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T
}

final class RequestProcessor: RequestProcessorProtocol {
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }
    
    
    func request<T: Decodable>(endpoint: Endpoint, type: T.Type) async throws -> T {
        do {
            let (data, response) = try await session.data(for: urlRequest(endpoint: endpoint))
            return try self.handleResponse(data: data, response: response)
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError.unknown
        }
    }
    
    private func handleResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw ApiError.decodingError
            }
        default:
            throw ApiError.unknown // TODO: handle backend errors
        }
    }
}

// MARK: URLRequest Creation
private extension RequestProcessor {
    func urlRequest(endpoint: Endpoint) throws(ApiError) -> URLRequest {
        
        guard let url = URL(string: endpoint.baseURL) else {
            throw .URLError
        }
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(endpoint.path))
        
        // HTTP Method
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // Headers
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = endpoint.token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
            
        urlRequest = addQueryItems(to: urlRequest, with: endpoint.queryItems ?? [])
        
        try addHTTPBody(to: &urlRequest, with: endpoint.body)
        
        return urlRequest
    }
    
    func addQueryItems(to urlRequest: URLRequest, with parameters: [URLQueryItem]) -> URLRequest {
        guard !parameters.isEmpty,
              let url = urlRequest.url,
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return urlRequest }
        
        var newURLRequest = urlRequest
        
        urlComponents.queryItems = parameters
        
        guard let newURL = urlComponents.url else { return urlRequest }

        newURLRequest.url = newURL

        return newURLRequest
    }
    
    func addHTTPBody(to urlRequest: inout URLRequest, with body: [String: Any]?) throws(ApiError) {
        guard let body = body else { return }
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            throw .encodingError
        }
    }
}

// http body vs query items
