//
//  UserModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import CoreData

struct UserModel: Identifiable {
    let id: String
    var name: String
    var email: String
    var phone: String
    let objectID: NSManagedObjectID?
    
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
    
    init(id: String, name: String, email: String, phone: String, objectID: NSManagedObjectID? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.objectID = objectID
    }
    
    init(user: UserDetailsModel, objectID: NSManagedObjectID? = nil) {
        self.id = UUID().uuidString
        self.name = "\(user.firstName) \(user.lastName)"
        self.email = user.email
        self.phone = user.phone
        self.objectID = objectID
    }
    
    init(userDTO: UserDTO, objectID: NSManagedObjectID? = nil) {
        self.id = userDTO.id.description
        self.name = userDTO.name
        self.email = userDTO.email
        self.phone = ""
        self.objectID = objectID
    }
    
    init(userCD: UserCD) {
        self.id = userCD.userID ?? UUID().uuidString
        self.name = userCD.name ?? "N/A"
        self.email = userCD.email ?? "N/A"
        self.phone = userCD.phone ?? "N/A"
        self.objectID = userCD.objectID
    }
}
