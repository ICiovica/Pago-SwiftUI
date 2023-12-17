//
//  NewUserView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct NewUserView: View {
    @Environment(\.dismiss) var dismiss
    @State private var newUser = NewUserModel()
    let action: (UserModel) -> Void
    
    var body: some View {
        List {
            ForEach(UserDetail.allCases, id: \.id) { detail in
                Section {
                    DetailInputView(newUser: $newUser, detail: detail)
                        .foregroundStyle(Color.listTextForeground)
                }
            }
        }
        .overlay { saveBtnVw }
    }
}

// MARK: - Views
private extension NewUserView {
    var saveBtnVw: some View {
        VStack {
            Spacer()
            Button {
                saveTapped()
            } label: {
                saveBtnLabel
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    var saveBtnLabel: some View {
        Text("users_add_new_save")
            .font(.system(.title3, design: .rounded, weight: .semibold))
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color.saveButtonBackground)
            .foregroundStyle(.white)
            .cornerRadius(12)
            .padding()
    }
}

// MARK: - Methods
private extension NewUserView {
    func saveTapped() {
        guard newUser.isValid else { return }
        action(UserModel(user: newUser))
        dismiss()
    }
}

#Preview {
    NewUserView() {_ in}
}
