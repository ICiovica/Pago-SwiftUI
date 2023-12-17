//
//  CoreDataTests.swift
//  Pago-SwiftUITests
//
//  Created by IonutCiovica on 17/12/2023.
//

import XCTest
@testable import Pago_SwiftUI

final class CoreDataTests: XCTestCase {
    override func setUp() {
        super.setUp()
        cleanUpCoreData()
    }
    
    override func tearDown() {
        super.tearDown()
        cleanUpCoreData()
    }
    
    private func cleanUpCoreData() {
        do {
            try CoreDataService().cleanUpUsers()
        } catch {
            XCTFail("Error cleaning up Core Data: \(error)")
        }
    }
    
    func testAddUserToCoreData() {
        let user = UserModel(id: "123", name: "John Doe", email: "john@example.com", phone: "1234567890")
        do {
            try CoreDataService().add(user)
            let fetchedUsers = try CoreDataService().fetch()
            XCTAssertEqual(fetchedUsers.count, 1, "There should be one user in Core Data")
            let savedUser = fetchedUsers.first!
            XCTAssertEqual(savedUser.userID, user.id, "User ID should match")
            XCTAssertEqual(savedUser.name, user.name, "User name should match")
            XCTAssertEqual(savedUser.email, user.email, "User email should match")
            XCTAssertEqual(savedUser.phone, user.phone, "User phone should match")
        } catch {
            XCTFail("Error adding user: \(error)")
        }
    }
    
    func testAddUsersToCoreData() {
        let users = [
            UserModel(id: "1", name: "John Doe", email: "john@example.com", phone: "1234567890"),
            UserModel(id: "2", name: "Jane Doe", email: "jane@example.com", phone: "9876543210")
        ]
        
        do {
            try CoreDataService().add(users)
            let fetchedUsers = try CoreDataService().fetch()
            XCTAssertEqual(fetchedUsers.count, 2, "There should be two users in Core Data")
            
            for user in users {
                let savedUser = fetchedUsers.first { $0.userID == user.id }
                XCTAssertNotNil(savedUser, "User should be saved to Core Data")
                XCTAssertEqual(savedUser?.name, user.name, "User name should match")
                XCTAssertEqual(savedUser?.email, user.email, "User email should match")
                XCTAssertEqual(savedUser?.phone, user.phone, "User phone should match")
            }
        } catch {
            XCTFail("Error adding users: \(error)")
        }
    }
    
    func testUpdateUser() {
        let initialUser = UserModel(id: "1", name: "John Doe", email: "john@example.com", phone: "1234567890")
        let updatedDetails = UserDetailsModel(firstName: "UpdatedJohn", lastName: "UpdatedDoe", phone: "5555555555", email: "updatedjohn@example.com")
        
        do {
            try CoreDataService().add(initialUser)
            try CoreDataService().updateUser(initialUser, with: updatedDetails)
            
            let fetchedUsers = try CoreDataService().fetch()
            XCTAssertEqual(fetchedUsers.count, 1, "There should be one user in Core Data")
            
            let updatedUser = fetchedUsers.first!
            XCTAssertEqual(updatedUser.name, "UpdatedJohn UpdatedDoe", "User name should be updated")
            XCTAssertEqual(updatedUser.email, "updatedjohn@example.com", "User email should be updated")
            XCTAssertEqual(updatedUser.phone, "5555555555", "User phone should be updated")
        } catch {
            XCTFail("Error updating user: \(error)")
        }
    }
}
