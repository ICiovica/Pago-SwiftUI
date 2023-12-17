//
//  MockAPIRequest.swift
//  Pago-SwiftUITests
//
//  Created by IonutCiovica on 17/12/2023.
//

import Foundation
@testable import Pago_SwiftUI

enum MockAPIResponse {
    static let fetchedUser: Response = [
        UserDTO(id: 1, name: "Test User", email: "test@example.com", status: .inactive)
    ]
}

class MockAPIRequest {
    private let result: Result<Response, Error>
    
    init(result: Result<Response, Error>) {
        self.result = result
    }
    
    func getUsers() async throws -> Result<Response, Error> {
        let (data, response) = try await getURLContent()
        return try verifyResponse(data: data, response: response)
    }
    
    func getURLContent() async throws -> (Data, URLResponse) {
        let data = try JSONEncoder().encode(MockAPIResponse.fetchedUser)
        let response = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        return (data, response)
    }
    
    func verifyResponse(data: Data, response: URLResponse) throws -> Result<Response, Error> {
        return result
    }
}
