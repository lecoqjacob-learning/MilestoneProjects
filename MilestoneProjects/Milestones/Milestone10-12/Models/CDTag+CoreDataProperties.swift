//
//  CDTag+CoreDataProperties.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/2/21.
//
//

import Foundation
import CoreData


extension CDTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTag> {
        return NSFetchRequest<CDTag>(entityName: "CDTag")
    }

    @NSManaged public var name: String?
    @NSManaged public var tagOrigin: CDUser?

    internal var wrappedName: String {
        return name ?? ""
    }
}

extension CDTag : Identifiable {

}
