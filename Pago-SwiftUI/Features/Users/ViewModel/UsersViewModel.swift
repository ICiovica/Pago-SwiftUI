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
    
    @Published var user = UserDetailsModel()
    
    @MainActor func fetchUsers() async {
        guard users.isEmpty else { return }
        defer {
            isLoading = false
        }
        isLoading = true
        do {
            let result = try await APIRequest().getUsers()
            switch result {
            case .success(let response):
                let activeUsers = response.filter({ $0.status.rawValue.lowercased() == "inactive" })
                users = activeUsers.map({ UserModel(userDTO: $0) })
            case .failure(let error):
                handleFetchAlert()
                print("Error: \(error.localizedDescription)")
            }
        } catch {
            handleFetchAlert()
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func addNewUser(completion: @escaping () -> Void) {
        guard user.isValid else { return }
        users.append(UserModel(user: user))
        completion()
    }
    
    func updateUser(_ user: UserModel, completion: @escaping () -> Void) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index].name = "\(self.user.firstName) \(self.user.lastName)"
            users[index].phone = self.user.phone
            users[index].email = self.user.email
            completion()
        }
    }
    
    func handleFetchAlert() {
        fetchAlertModel.isPresented.toggle()
    }
}

// MARK: - User Details
extension UsersViewModel {
    func handleUserDetails(_ user: UserModel?) {
        if let user {
            userTappedWithDetails(user)
        } else {
            resetUserDetails()
        }
    }
    
    private func userTappedWithDetails(_ user: UserModel) {
        let nameComponents = user.name.components(separatedBy: " ")
        if nameComponents.count >= 2 {
            self.user.firstName = nameComponents[0]
            self.user.lastName = nameComponents.suffix(from: 1).joined(separator: " ")
        }
        self.user.email = user.email
        self.user.phone = user.phone
    }
    
    private func resetUserDetails() {
        user.firstName = ""
        user.lastName = ""
        user.email = ""
        user.phone = ""
    }
}
