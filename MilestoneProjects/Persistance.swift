import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let milestone10_12 = PersistenceController(storeName: "CoreData2")

    // Storage for Core Data
    let container: NSPersistentContainer

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(storeName: String, inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: storeName)
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
