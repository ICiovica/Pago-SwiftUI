//
//  UserDetail.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 17/12/2023.
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
