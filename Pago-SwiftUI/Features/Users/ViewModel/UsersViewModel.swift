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
    var coreDataAlert = CoreDataAlert()
    
    @Published var user = UserDetailsModel()
    
    @MainActor private func fetchUsers() async -> [UserModel] {
        defer {
            isLoading = false
        }
        isLoading = true
        do {
            let result = try await APIRequest().getUsers()
            switch result {
            case .success(let response):
                let activeUsers = response.filter({ $0.status.rawValue.lowercased() == "inactive" })
                return activeUsers.map({ UserModel(userDTO: $0) })
            case .failure(let error):
                handleFetchAlert()
                print("Error: \(error.localizedDescription)")
            }
        } catch {
            handleFetchAlert()
            print("Error: \(error.localizedDescription)")
        }
        return []
    }
    
    @MainActor func loadUsers() async {
        do {
            let usersCD = try CoreDataService().fetch()
            if usersCD.isEmpty {
                users = await fetchUsers()
                try CoreDataService().add(users)
            } else {
                users = usersCD.map {UserModel(userCD: $0)
                }
            }
        } catch {
            coreDataAlert.title = "core_data_alert_fetch_title"
            coreDataAlert.message = "core_data_alert_fetch_message"
            coreDataAlert.isPresented = true
            print("Fetch CD operation failed: \(error.localizedDescription)")
        }
    }
    
    func addNewUser(completion: @escaping () -> Void) {
        guard user.isValid else { return }
        do {
            let user = UserModel(user: user)
            try CoreDataService().add(user)
            users.append(user)
            completion()
        } catch {
            coreDataAlert.isPresented = true
            print("Add CD operation failed: \(error.localizedDescription)")
        }
    }
    
    func updateUser(_ user: UserModel, completion: @escaping () -> Void) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            do {
                try CoreDataService().updateUser(user, with: self.user)
                users[index].name = "\(self.user.firstName) \(self.user.lastName)"
                users[index].phone = self.user.phone
                users[index].email = self.user.email
                completion()
            } catch {
                coreDataAlert.isPresented = true
                print("Update CD operation failed: \(error.localizedDescription)")
            }
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
