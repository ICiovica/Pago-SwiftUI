//
//  UsersListView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct UsersListView: View {
    @ObservedObject var vm: UsersViewModel
    
    var body: some View {
        List {
            sectionTitleVw
            ForEach(vm.users, id: \.id) { user in
                UserView(user: user)
            }
        }
        .listStyle(.plain)
        .overlay {
            if vm.isLoading { ProgressView() }
        }
        .alert(LocalizedStringKey(vm.fetchAlertModel.title),
               isPresented: $vm.fetchAlertModel.isPresented,
               actions: {
            Button("general_dismiss") {
                vm.handleFetchAlert()
            }
        },
               message: {
            Text(LocalizedStringKey(vm.fetchAlertModel.message))
        })
        .task {
            await vm.fetchUsers()
        }
    }
}

// MARK: - Views
private extension UsersListView {
    var sectionTitleVw: some View {
        Text("users_section_title")
            .font(.system(.body, design: .rounded, weight: .semibold))
            .foregroundStyle(Color.listTextForeground)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.listRowBackground)
    }
}

#Preview {
    UsersListView(vm: UsersViewModel())
}
