//
//  APIRequest.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import os.log
import Foundation

private enum APIError: Error {
    case urlSessionFailed
    case badRequest(Int)
    case serverError(Int)
    case unknown
}

final class APIRequest {
    private let baseURL = "https://gorest.co.in/public/v2/users"
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getUsers() async throws -> Result<Response, Error> {
        let (data, response) = try await getURLContent()
        return try verifyResponse(data: data, response: response)
    }
    
    private func verifyResponse(data: Data, response: URLResponse) throws -> Result<Response, Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            os_log("APIError - Unknown", log: .default, type: .error)
            return .failure(APIError.unknown)
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Response.self, from: data)
                return .success(result)
            } catch {
                os_log("Failed to decode response: %{public}s", log: .default, type: .error, error.localizedDescription)
                return .failure(error)
            }
        case 400..<500:
            os_log("APIError - Bad Request, code: %{public}d", log: .default, type: .error, httpResponse.statusCode)
            throw APIError.badRequest(httpResponse.statusCode)
        case 500..<600:
            os_log("APIError - Server Error, code: %{public}d", log: .default, type: .error, httpResponse.statusCode)
            throw APIError.serverError(httpResponse.statusCode)
        default:
            os_log("APIError - Unknown", log: .default, type: .error)
            throw APIError.unknown
        }
    }
    
    private func getURLContent() async throws  -> (Data, URLResponse) {
        let request = URLRequest(url: URL(string: baseURL)!)
        do {
            let (data, response) = try await urlSession.data(for: request)
            return (data, response)
        } catch {
            os_log("APIError - URL Session Failed", log: .default, type: .error)
            throw APIError.urlSessionFailed
        }
    }
}
