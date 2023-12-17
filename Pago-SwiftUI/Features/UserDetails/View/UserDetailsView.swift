//
//  UserDetailsView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct UserDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: UsersViewModel
    let user: UserModel?
    
    var body: some View {
        List {
            ForEach(UserDetail.allCases, id: \.id) { detail in
                InputDetailView(user: $vm.user, detail: detail)
                    .foregroundStyle(Color.listTextForeground)
            }
        }
        .navigationTitle(user == nil ? "user_add_new_title" : "user_update_title")
        .navigationBarTitleDisplayMode(.large)
        .overlay { saveBtnVw }
        .onAppear { vm.handleUserDetails(user) }
    }
}

// MARK: - Views
private extension UserDetailsView {
    var saveBtnVw: some View {
        VStack {
            Spacer()
            Button {
                if let user {
                    vm.updateUser(user) { dismiss() }
                } else {
                    vm.addNewUser() { dismiss() }
                }
            } label: {
                saveBtnLabel
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    var saveBtnLabel: some View {
        Text(user == nil ? "user_add_new_save" : "user_update_save")
            .font(.system(.title3, design: .rounded, weight: .semibold))
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color.saveButtonBackground)
            .foregroundStyle(.white)
            .cornerRadius(12)
            .padding()
    }
}

#Preview {
    UserDetailsView(vm: UsersViewModel(), user: nil)
}
