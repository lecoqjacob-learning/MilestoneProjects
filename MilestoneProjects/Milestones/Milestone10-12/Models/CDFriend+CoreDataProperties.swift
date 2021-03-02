//
//  CDFriend+CoreDataProperties.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/1/21.
//
//

import CoreData
import Foundation

public extension CDFriend {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged var id: UUID
    @NSManaged var name: String?
    @NSManaged var friendOrigin: CDUser?

    internal var wrappedId: UUID {
        return id
    }

    internal var wrappedName: String {
        return name ?? ""
    }

    internal var friendsArray: [CDUser] {
//        let set = friends as? Set<CDUser> ?? []
//
//        return set.sorted {
//            $0.wrappedName < $1.wrappedName
//        }
        return []
    }
}

// MARK: Generated accessors for friends

public extension CDFriend {
    @objc(addFriendsObject:)
    @NSManaged func addToFriends(_ value: CDUser)

    @objc(removeFriendsObject:)
    @NSManaged func removeFromFriends(_ value: CDUser)

    @objc(addFriends:)
    @NSManaged func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged func removeFromFriends(_ values: NSSet)
}

extension CDFriend: Identifiable {}
