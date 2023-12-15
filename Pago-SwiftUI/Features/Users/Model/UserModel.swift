//
//  UserModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

struct UserModel: Identifiable {
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
    
    init(id: Int, name: String, email: String, gender: String, status: String) {
        self.id = id
        self.name = name
        self.email = email
        self.gender = gender
        self.status = status
    }
    
    init(userDTO: UserDTO) {
        self.id = userDTO.id
        self.name = userDTO.name
        self.email = userDTO.email
        self.gender = userDTO.gender.rawValue
        self.status = userDTO.status.rawValue
    }
}
