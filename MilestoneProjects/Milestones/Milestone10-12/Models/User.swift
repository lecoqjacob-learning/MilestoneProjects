//
//  User.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import Foundation
import SwiftUI

struct FriendModel: Decodable, Identifiable, Hashable {
    var id: UUID
    var name: String
}

extension FriendModel {
    init(friend: CDFriend) {
        self.id = friend.wrappedId
        self.name = friend.wrappedName
    }
}

struct UserModel: Decodable, Identifiable {
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
    init(user: CDUser) {
        self.id = user.wrappedId
        self.isActive = user.isActive
        self.name = user.wrappedName
        self.age = user.wrappedAge
        self.company = user.wrappedCompany
        self.email = user.wrappedEmail
        self.address = user.wrappedAddress
        self.about = user.wrappedAbout
        self.registered = user.wrappedRegistered
        self.tags = user.tagsArray.map{ $0.wrappedName }
        self.friends = user.friendsArray.map { FriendModel(friend: $0) }
    }

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
