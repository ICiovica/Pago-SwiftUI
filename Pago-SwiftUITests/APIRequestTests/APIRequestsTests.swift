//
//  APIRequestsTests.swift
//  Pago-SwiftUITests
//
//  Created by IonutCiovica on 17/12/2023.
//

import XCTest
@testable import Pago_SwiftUI

class APIRequestTests: XCTestCase {
    func testGetUsersSuccess() async {
        let mockAPIRequest = MockAPIRequest(result: .success(MockAPIResponse.fetchedUser))
        let expectation = XCTestExpectation(description: "Async Test Success")
        do {
            let result = try await mockAPIRequest.getUsers()
            switch result {
            case .success(let response):
                XCTAssertEqual(response, MockAPIResponse.fetchedUser, "Response should match the predefined success response")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but received failure")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testGetUsersFailure() async {
        let mockAPIRequest = MockAPIRequest(result: .failure(APIError.unknown))
        let expectation = XCTestExpectation(description: "Async Test Failure")
        do {
            let result = try await mockAPIRequest.getUsers()
            switch result {
            case .success:
                XCTFail("Expected success but received failure")
            case .failure(let error):
                XCTAssertTrue(error is APIError, "Expected APIError")
                expectation.fulfill()
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
