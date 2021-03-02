//
//  UserViewModel.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import CoreData
import Foundation

extension NSManagedObject {
    func addObject(value: NSManagedObject, forKey key: String) {
        let items = mutableSetValue(forKey: key)
        items.add(value)
    }

    func removeObject(value: NSManagedObject, forKey key: String) {
        let items = mutableSetValue(forKey: key)
        items.remove(value)
    }
}

class UserViewModel: ObservableObject {
    @Published var users = [UserModel]()
    @Published var error: String?

    var objectContext: NSManagedObjectContext?

    func fetchUsers() {
        UserService().getUsers { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.saveUsers(users: users)
                    self.loadUsers()
                }
            case .failure:
                print("Error")
            }
        }
    }

    func saveUsers(users: [UserModel]) {
        guard let context = objectContext else { return }

        context.performAndWait {
            for user in users {
                let cdUser = CDUser(context: context)
                cdUser.id = user.id
                cdUser.name = user.name
                cdUser.age = Int16(user.age)
                cdUser.about = user.about
                cdUser.company = user.company
                cdUser.email = user.email
                cdUser.address = user.address

                for friend in user.friends {
                    let cdFriend = CDFriend(context: context)

                    cdFriend.id = friend.id
                    cdFriend.name = friend.name
                    cdFriend.friendOrigin = cdUser.self
                }

                for tag in user.tags {
                    let newTag = CDTag(context: context)

                    newTag.name = tag
                    newTag.tagOrigin = cdUser.self
                }
            }
        }

        if context.hasChanges {
            try? context.save()
        }
    }

    func loadUsers() {
        guard let context = objectContext else { return }

        let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        if let result = try? context.fetch(fetchRequest) {
            users.removeAll()

            for fetchedUser in result {
                users.append(UserModel(user: fetchedUser))
            }
        }
    }

    func deleteUsers() {
        guard let context = objectContext else { return }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()

        fetchRequest.entity = CDUser.entity()
        fetchRequest.includesPropertyValues = false

        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                if let object = managedObject as? NSManagedObject {
                    context.delete(object)
                }
            }

            if context.hasChanges {
                try? context.save()
                users.removeAll()
            }
        } catch let error as NSError {
            print("Delete All Error : \(error) ")
        }
    }

    func findUser(_ id: UUID) -> UserModel? {
        print(id)
        if let user = users.first(where: { $0.id == id }) {
            return user
        }

        return users.first
    }
}
