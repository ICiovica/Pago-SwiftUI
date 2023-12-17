//
//  UserModelTests.swift
//  Pago-SwiftUITests
//
//  Created by IonutCiovica on 17/12/2023.
//

import XCTest
@testable import Pago_SwiftUI

class UserModelTests: XCTestCase {
    func testPlaceHolderInitials() {
        // Test when name has two components
        let userModel1 = UserModel(id: "1", name: "John Doe", email: "john@example.com", phone: "123456789")
        XCTAssertEqual(userModel1.placeHolderInitials, "JD", "Incorrect placeholder initials for two-component name")

        // Test when name has more than two components
        let userModel2 = UserModel(id: "2", name: "John James Doe", email: "john@example.com", phone: "123456789")
        XCTAssertEqual(userModel2.placeHolderInitials, "JJ", "Incorrect placeholder initials for more than two-component name")

        // Test when name has less than two components
        let userModel3 = UserModel(id: "3", name: "John", email: "john@example.com", phone: "123456789")
        XCTAssertEqual(userModel3.placeHolderInitials, "N/A", "Incorrect placeholder initials for less than two-component name")
    }

    func testImageURL() {
        // Test when ID is an even number
        let userModel1 = UserModel(id: "2", name: "John Doe", email: "john@example.com", phone: "123456789")
        XCTAssertNil(userModel1.imageURL, "Image URL should be nil for odd ID")

        // Test when ID is an odd number
        let userModel2 = UserModel(id: "3", name: "Jane Doe", email: "jane@example.com", phone: "987654321")
        XCTAssertNotNil(userModel2.imageURL, "Image URL should be created for even ID")
    }
}
