//
//  PersistenceController.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import CoreData
import Foundation

class CoreDataStorageService {
    static let shared = CoreDataStorageService()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "BookSearch")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }

    private var context: NSManagedObjectContext {
        container.viewContext
    }

    func saveBook(_ book: Book) {
        guard !isFavorite(book) else { return }
        let entity = BookEntity(context: context)
        entity.id = book.id
        entity.title = book.title
        entity.authors = book.authors.joined(separator: "|||")
        entity.publisher = book.publisher
        entity.coverID = Int32(book.coverID ?? 0)
        try? context.save()
    }

    func fetchBooks() -> [Book] {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        let entities = (try? context.fetch(request)) ?? []
        return entities.map { $0.toBook() }
    }

    func deleteBook(_ book: Book) {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", book.id)
        guard let entity = try? context.fetch(request).first else { return }
        context.delete(entity)
        try? context.save()
    }

    func isFavorite(_ book: Book) -> Bool {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", book.id)
        return ((try? context.count(for: request)) ?? 0) > 0
    }
}
