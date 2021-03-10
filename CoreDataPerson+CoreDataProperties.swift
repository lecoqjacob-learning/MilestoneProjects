//
//  CoreDataPerson+CoreDataProperties.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/3/21.
//
//

import CoreData
import Foundation

public extension CoreDataPerson {
    @nonobjc class func createFetchRequest() -> NSFetchRequest<CoreDataPerson> {
        return NSFetchRequest<CoreDataPerson>(entityName: "CoreDataPerson")
    }

    @NSManaged var id: UUID?
    @NSManaged var imagePath: String?
    @NSManaged var internalName: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var locationRecorded: Bool

    var name: String {
        get {
            internalName ?? "Unknown name"
        }

        set {
            internalName = newValue
        }
    }
}

extension CoreDataPerson: Identifiable {}
