//
//  UserModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

struct UserModel: Identifiable {
    let id: String
    var name: String
    var email: String
    var phone: String
    
    var placeHolderInitials: String {
        let nameComponents = name.components(separatedBy: " ")
        if nameComponents.count >= 2 {
            if let firstInital = nameComponents[0].first?.description,
               let secondInitial = nameComponents.suffix(from: 1).joined(separator: " ").first?.description {
                return "\(firstInital)\(secondInitial)"
            }
        }
        return "N/A"
    }
    
    var imageURL: URL? {
        if let number = Int(id),
           !number.isMultiple(of: 2) {
            return URL(string: "https://picsum.photos/200/200")
        }
        return nil
    }
    
    init(id: String, name: String, email: String, phone: String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    init(user: UserDetailsModel) {
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
