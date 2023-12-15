//
//  ContentView.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            UsersListView()
                .navigationTitle("users_navigation_title")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
