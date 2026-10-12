//
//  CoreDataFavoritesService.swift
//  ZooShop
//
//  Created by Aleksandr Potemkin on 09.10.2026.
//

import CoreData

@MainActor
final class CoreDataFavoritesService: FavoritesService {
    
    // MARK: - Properties
    
    private let persistence: PersistenceController
    
    // MARK: - Initialization

    init(
        inMemory: Bool = false,
        bundle: Bundle = .main,
        storeURL: URL? = nil
    ) throws {
        persistence = try PersistenceController(inMemory: inMemory, bundle: bundle, storeURL: storeURL)
    }
    
    // MARK: - Public Properties

    func fetchProductIDs() throws -> Set<String> {
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
        let records = try persistence.container.viewContext.fetch(request)
        return Set(records.compactMap { $0.value(forKey: "productID") as? String })
    }

    func setFavorite(_ isFavorite: Bool, productID: String) throws {
        let context = persistence.container.viewContext
        do {
            let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteProduct")
            request.predicate = NSPredicate(format: "productID == %@", productID)
            let existing = try context.fetch(request)
            if isFavorite {
                if existing.isEmpty {
                    let record = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
                    record.setValue(productID, forKey: "productID")
                    record.setValue(Date(), forKey: "addedAt")
                }
            } else {
                existing.forEach(context.delete)
            }
            if context.hasChanges {
                try context.save()
            }
        } catch {
            context.rollback()
            throw error
        }
    }

}
