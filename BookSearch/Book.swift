//
//  Book.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//


import Foundation
 
struct Book: Identifiable, Codable, Equatable {
    var id: String
    var title: String
    var authors: [String]
    var publisher: String?
    var coverID: Int?

    var coverURL: URL? {
        if let coverID = coverID {
            return URL(string: "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg")
        }
        return nil
    }
}
 
struct SearchResponse: Codable {
    var docs: [BookDoc]
}
 
struct BookDoc: Codable {
    var key: String
    var title: String
    var author_name: [String]?
    var publisher: [String]?
    var cover_i: Int?
 
    func toBook() -> Book {
        return Book(
            id: key,
            title: title,
            authors: author_name ?? [],
            publisher: publisher?.first,
            coverID: cover_i
        )
    }
}
