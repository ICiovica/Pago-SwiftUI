//
//  UserDTO.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

// MARK: - Response
typealias Response = [UserDTO]

// MARK: - User
struct UserDTO: Codable {
    let id: Int
    let name, email: String
    let gender: Gender
    let status: Status
}

// MARK: - Gender
enum Gender: String, Codable {
    case female = "female"
    case male = "male"
}

// MARK: - Status
enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}
