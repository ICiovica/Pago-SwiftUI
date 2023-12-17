//
//  UserModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

struct UserModel: Identifiable {
    let id: String
    let name: String
    let email: String
    let phone: String
    
    init(id: String, name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    init(user: NewUserModel) {
        self.id = UUID().uuidString
        self.name = "\(user.firstName) \(user.lastName)"
        self.email = user.email
        self.phone = user.phone
    }
    
    init(userDTO: UserDTO) {
        self.id = userDTO.id.description
        self.name = userDTO.name
        self.email = userDTO.email
        self.phone = ""
    }
}
