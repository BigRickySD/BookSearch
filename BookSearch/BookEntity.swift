//
//  BookEntity.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import CoreData

@objc(BookEntity)
class BookEntity: NSManagedObject {
    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var authors: String
    @NSManaged var publisher: String?
    @NSManaged var coverID: Int32

    @nonobjc class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    func toBook() -> Book {
        Book(
            id: id,
            title: title,
            authors: authors.isEmpty ? [] : authors.components(separatedBy: "|||"),
            publisher: publisher,
            coverID: coverID == 0 ? nil : Int(coverID)
        )
    }
}
