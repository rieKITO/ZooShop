import CoreData

@MainActor
final class PersistenceController {
    
    // MARK: - Properties
    
    let container: NSPersistentContainer
    
    // MARK: - Initialization

    init(
        inMemory: Bool = false,
        bundle: Bundle = .main,
        storeURL: URL? = nil
    ) throws {
        guard
            let modelURL = bundle.url(forResource: "ZooShop", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelURL)
        else {
            throw PersistenceError.missingModel
        }

        container = NSPersistentContainer(name: "ZooShop", managedObjectModel: model)
        let description = NSPersistentStoreDescription()
        description.type = inMemory ? NSInMemoryStoreType : NSSQLiteStoreType
        description.url = storeURL ?? NSPersistentContainer.defaultDirectoryURL()
            .appendingPathComponent("ZooShop.sqlite")

        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions = [description]

        var loadingError: Error?
        
        container.loadPersistentStores { _, error in
            loadingError = error
        }
        
        if let loadingError {
            throw loadingError
        }
        
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // MARK: - Error

    enum PersistenceError: LocalizedError {
        case missingModel

        var errorDescription: String? {
            String(localized: "Favorites.error.missingModel")
        }
    }
}
