//
//  CDUser+CoreDataProperties.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/1/21.
//
//

import CoreData
import Foundation

public extension CDUser {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged var id: UUID
    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var about: String?
    @NSManaged var address: String?
    @NSManaged var age: Int16
    @NSManaged var company: String?
    @NSManaged var isActive: Bool
    @NSManaged var registered: String?
    @NSManaged var tags: NSSet?
    @NSManaged var friends: NSSet?

    internal var wrappedId: UUID {
        return id
    }

    internal var wrappedName: String {
        return name ?? ""
    }

    internal var wrappedEmail: String {
        return email ?? ""
    }

    internal var wrappedAbout: String {
        return about ?? ""
    }
    
    internal var wrappedAddress: String {
        return address ?? ""
    }

    internal var wrappedAge: Int {
        return Int(age)
    }

    internal var wrappedCompany: String {
        return company ?? ""
    }

    internal var wrappedRegistered: String {
        return registered ?? ""
    }

    internal var tagsArray: [CDTag] {
        let set = tags as? Set<CDTag> ?? []

        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

    internal var friendsArray: [CDFriend] {
        let set = friends as? Set<CDFriend> ?? []

        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends

public extension CDUser {
    @objc(addFriendsObject:)
    @NSManaged func addToFriends(_ value: CDFriend)

    @objc(removeFriendsObject:)
    @NSManaged func removeFromFriends(_ value: CDFriend)

    @objc(addFriends:)
    @NSManaged func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged func removeFromFriends(_ values: NSSet)
    
    @objc(addTagsObject:)
    @NSManaged func addToTags(_ value: CDTag)
    
    @objc(addTags:)
    @NSManaged func addToTags(_ values: NSSet)
}

extension CDUser: Identifiable {}
