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
            imageVw
            Text(user.name)
            Spacer()
        }
    }
}

// MARK: - Views
private extension UserView {
    var imageVw: some View {
        AsyncImageCache(url: user.imageURL, placeholderInitials: user.placeHolderInitials) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UserConstants.imageFrame)
                .clipShape(Circle())
        }
    }
}

#Preview {
    UserView(user: .init(id: "123", name: "John Doe", email: "john.doe@gmail.com", phone: "0744123123"))
}
