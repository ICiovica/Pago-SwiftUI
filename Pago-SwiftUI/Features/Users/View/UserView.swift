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
            Text(user.id)
            Text(user.name)
            Text(user.email)
            Text(user.phone)
        }
    }
}

#Preview {
    UserView(user: .init(id: "123", name: "John Doe", email: "john.doe@gmail.com", phone: "0744123123"))
}
