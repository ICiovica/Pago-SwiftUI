//
//  CoreDataService.swift
//  Pago-SwiftUI
//
//  Created by IonutCiovica on 17/12/2023.
//

import CoreData

private enum CoreDataError: Error {
    case objectNotFound(id: String)
}

struct CoreDataService {
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func fetch() throws -> [UserCD] {
        return try container.viewContext.performAndWait {
            let objects = try container.viewContext.fetch(UserCD.fetchRequest())
            return objects
        }
    }
    
    func delete(_ user: UserModel) throws {
        try container.viewContext.performAndWait {
            let object = try createObject(from: user)
            container.viewContext.delete(object)
            try container.viewContext.save()
        }
    }
    
    func add(_ user: UserModel) throws {
        try container.viewContext.performAndWait {
            let userCD = UserCD(context: container.viewContext)
            configure(userCD, with: user)
            try container.viewContext.save()
        }
    }
    
    func add(_ users: [UserModel]) throws {
        try container.viewContext.performAndWait {
            for user in users {
                let userCD = UserCD(context: container.viewContext)
                configure(userCD, with: user)
                try container.viewContext.save()
            }
        }
    }
    
    func updateUser(_ user: UserModel, with details: UserDetailsModel) throws {
        try container.viewContext.performAndWait {
            let object = try createObject(from: user)
            object.name = "\(details.firstName) \(details.lastName)"
            object.email = details.email
            object.phone = details.phone
            try container.viewContext.save()
        }
    }
    
    private func configure(_ userCD: UserCD, with user: UserModel) {
        userCD.userID = user.id
        userCD.name = user.name
        userCD.phone = user.phone
        userCD.email = user.email
    }
    
    private func createObject(from user: UserModel) throws -> UserCD {
        var object: UserCD?
        if let objectID = user.objectID {
            object = try container.viewContext.existingObject(with: objectID) as? UserCD
        } else {
            let fetchedUsers = try fetch()
            object = fetchedUsers.first(where: { $0.userID == user.id })
        }
        guard let object else { throw CoreDataError.objectNotFound(id: user.id) }
        return object
    }
}
