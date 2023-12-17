//
//  UserDetailsModelTests.swift
//  Pago-SwiftUITests
//
//  Created by IonutCiovica on 17/12/2023.
//

import XCTest
@testable import Pago_SwiftUI

class UserDetailsModelTests: XCTestCase {

    func testInvalidFirstName() {
        var userDetails = UserDetailsModel()
        userDetails.firstName = ""
        XCTAssertTrue(userDetails.invalidDetail(.firstName), "Invalid first name detection failed")
    }

    func testInvalidLastName() {
        var userDetails = UserDetailsModel()
        userDetails.lastName = ""
        XCTAssertTrue(userDetails.invalidDetail(.lastName), "Invalid last name detection failed")
    }

    func testInvalidPhoneFormat() {
        var userDetails = UserDetailsModel()
        userDetails.phone = "12345678900" // Invalid format, should be 10 digits
        XCTAssertTrue(userDetails.invalidDetail(.phone), "Invalid phone (format) detection failed")
    }

    func testValidPhone() {
        var userDetails = UserDetailsModel()
        userDetails.phone = "1234567890"
        XCTAssertFalse(userDetails.invalidDetail(.phone), "Valid phone detection failed")
    }

    func testInvalidEmailFormat() {
        var userDetails = UserDetailsModel()
        userDetails.email = "invalid_email"
        XCTAssertTrue(userDetails.invalidDetail(.email), "Invalid email (format) detection failed")
    }

    func testValidEmail() {
        var userDetails = UserDetailsModel()
        userDetails.email = "valid@example.com"
        XCTAssertFalse(userDetails.invalidDetail(.email), "Valid email detection failed")
    }

    func testIsValid() {
        // Test when all details are valid
        let userDetails1 = UserDetailsModel(firstName: "John", lastName: "Doe", phone: "1234567890", email: "john@example.com")
        XCTAssertTrue(userDetails1.isValid, "isValid for valid details")

        // Test when phone is empty
        let userDetails2 = UserDetailsModel(firstName: "Jane", lastName: "Doe", phone: "", email: "jane@example.com")
        XCTAssertTrue(userDetails2.isValid, "isValid for empty phone")
        
        // Test when email is empty
        let userDetails3 = UserDetailsModel(firstName: "Jane", lastName: "Doe", phone: "1234567890", email: "")
        XCTAssertTrue(userDetails3.isValid, "isValid for empty email")
    }
}
