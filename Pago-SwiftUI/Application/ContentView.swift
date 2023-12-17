//
//  ContentView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = UsersViewModel()
    
    var body: some View {
        NavigationStack {
            UsersListView(vm: vm)
                .navigationTitle("users_navigation_title")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) { trailingToolbarNavigationLinkVw }
                }
        }
    }
}

// MARK: - Views
private extension ContentView {
    var trailingToolbarVw: some View {
        VStack {
            Image(systemName: "person.fill.badge.plus")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.listTextForeground)
                .padding(6)
        }
        .frame(width: 32, height: 32)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.listTextForeground, lineWidth: 1)
        )
    }
    
    var trailingToolbarNavigationLinkVw: some View {
        NavigationLink {
            UserDetailsView(vm: vm, user: nil)
        } label: {
            trailingToolbarVw
        }
    }
}

#Preview {
    ContentView()
}
