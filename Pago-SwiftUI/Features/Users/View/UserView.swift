//
//  UserView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct UserView: View {
    let user: UserModel
    
    var body: some View {
        HStack {
            Text(user.id.description)
            Text(user.name)
            Text(user.email)
            Text(user.gender)
            Text(user.status)
        }
    }
}

#Preview {
    UserView(user: .init(id: 123, name: "John Doe", email: "john.doe@gmail.com", gender: "Male", status: "Active"))
}
