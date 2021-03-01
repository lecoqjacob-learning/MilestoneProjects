//
//  UserViewModel.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users = [UserModel]()

    func fetchUsers() {
        UserService().getUsers { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure:
                print("Error")
            }
        }
    }

    func findUser(_ id: UUID) -> UserModel? {
        if let user = users.first(where: { $0.id == id }) {
            return user
        }

        return users.first
    }
}
