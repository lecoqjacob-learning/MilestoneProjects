//
//  CoreDataPersons.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/3/21.
//

import CoreData
import Foundation

typealias Persons = CoreDataPersons

class CoreDataPersons: ObservableObject {
    private var container: NSPersistentContainer
    private var items = [CoreDataPerson]() {
        didSet {
            saveContext()
        }
    }
    
    /// Use add, update and remove functions for modification.
    @Published private(set) var all = [Person]()

    init() {
        container = NSPersistentContainer(name: "Milestone13_15")
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }

        loadSavedData()
    }
    
    func add(person: Person){
        let cdPerson = CoreDataPerson(context: container.viewContext)
        cdPerson.id = person.id
        cdPerson.imagePath = person.imagePath
        cdPerson.internalName = person.name
        cdPerson.latitude = person.latitude
        cdPerson.longitude = person.longitude
        cdPerson.locationRecorded = person.locationRecorded
        
        if let index = items.firstIndex(where: { $0.name > person.name }) {
            items.insert(cdPerson, at: index)
            all.insert(person, at: index)
        }
        else {
            items.append(cdPerson)
            all.append(person)
        }
    }
    
    func remove(persons: [Person]){
        for (index, item) in items.enumerated() {
            for person in persons {
                if (person.id == item.id){
                    all[index].deleteImage()
                    container.viewContext.delete(item)
                    items.remove(at: index)
                    all.remove(at: index)
                }
            }
        }
    }

    private func loadSavedData() {
        let request = CoreDataPerson.createFetchRequest()
        let sort = NSSortDescriptor(key: "internalName", ascending: true)
        request.sortDescriptors = [sort]

        do {
            items = try container.viewContext.fetch(request)

            // fill in "all" array
            for item in items {
                let id = item.id ?? UUID()
                
                // corupted data
                if item.id == nil {
                    item.id = id
                    saveContext()
                }

                let person = Person(id: id, name: item.name, imagePath: item.imagePath, locationRecorded: item.locationRecorded, latitude: item.latitude, longitude: item.longitude)
                all.append(person)
            }
        } catch {
            print("Fetch failed")
        }
    }

    private func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
