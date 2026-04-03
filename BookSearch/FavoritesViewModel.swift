//
//  FavoritesViewModel.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    var favoriteBooks: [Book] = []

    let storage = CoreDataStorageService.shared

    init() {
        loadFavorites()
    }

    func loadFavorites() {
        favoriteBooks = storage.fetchBooks()
    }

    func addFavorite(book: Book) {
        storage.saveBook(book)
        loadFavorites()
    }

    func removeFavorite(book: Book) {
        storage.deleteBook(book)
        loadFavorites()
    }

    func isFavorite(book: Book) -> Bool {
        favoriteBooks.contains { $0.id == book.id }
    }

    func toggleFavorite(book: Book) {
        if isFavorite(book: book) {
            removeFavorite(book: book)
        } else {
            addFavorite(book: book)
        }
    }

    func deleteFromList(at offsets: IndexSet) {
        for index in offsets {
            let book = favoriteBooks[index]
            storage.deleteBook(book)
        }
        loadFavorites()
    }
}
