//
//  UsersViewModel.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 15/12/2023.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published private(set) var users: [UserModel] = []
    @Published private(set) var isLoading = false
    var fetchAlertModel = FetchAlertModel()
    
    @MainActor func fetchUsers() async {
        defer {
            isLoading = false
        }
        isLoading = true
        do {
            let result = try await APIRequest().getUsers()
            switch result {
            case .success(let response):
                let fetchedUsers = response.map({ UserModel(userDTO: $0) })
                users = fetchedUsers
            case .failure(let error):
                handleFetchAlert()
                print("Error: \(error.localizedDescription)")
            }
        } catch {
            handleFetchAlert()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func handleFetchAlert() {
        fetchAlertModel.isPresented.toggle()
    }
}
