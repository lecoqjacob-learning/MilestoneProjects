//
//  User.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import Foundation
import SwiftUI

struct FriendModel: Codable, Identifiable {
    var id: UUID
    var name: String
}

struct UserModel: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [FriendModel]
}

extension UserModel {
    func getAddress() -> String {
        let addressComponents = self.address.components(separatedBy: ",")
        return "\(addressComponents[1]),\(addressComponents[2])"
    }
    
    static var example: UserModel {
        return UserModel(id: UUID(), isActive: false, name: "Dave", age: 22, company: "Imkan", email: "alfordrodriguez@imkan.com",
                         address: "907 Nelson Street, Cotopaxi, South Dakota, 5913",
                         about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt. ",
                         registered: "2015-11-10T01:47:18-00:00",
                         tags: [],
                         friends: [])
    }
}
