//
//  UserDetailsModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

struct UserDetailsModel {
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = ""
    var email: String = ""
    
    var isValid: Bool {
        UserDetail.allCases.allSatisfy({!invalidDetail($0)})
    }
    
    func invalidDetail(_ detail: UserDetail) -> Bool {
        switch detail {
        case .firstName:
            return firstName.isEmpty
        case .lastName:
            return lastName.isEmpty
        case .phone:
            guard !phone.isEmpty else { return false }
            let phoneRegex = #"^[0-9]{10}$"#
            return phone.range(of: phoneRegex, options: .regularExpression) == nil
        case .email:
            guard !email.isEmpty else { return false }
            let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
            return email.range(of: emailRegex, options: .regularExpression) == nil
        }
    }
    
    func invalidUpdate(_ user: UserModel) -> Bool {
        if user.name == "\(firstName) \(lastName)",
           user.phone == phone,
           user.email == email {
            return true
        }
        return false
    }
}
