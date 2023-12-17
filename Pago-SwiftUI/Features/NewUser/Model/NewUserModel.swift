//
//  NewUserModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

enum UserDetail: String, Identifiable, CaseIterable {
    case firstName = "NUME"
    case lastName = "PRENUME"
    case phone = "TELEFON"
    case email = "EMAIL"
    
    var id: String { self.rawValue }
    
    var alertDescription: String {
        switch self {
        case .firstName, .lastName:
            return "⚠️ This field is mandatory."
        case .phone:
            return "⚠️ Phone number wrong format."
        case .email:
            return "⚠️ Email address wrong format."
        }
    }
}

struct NewUserModel {
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
}
