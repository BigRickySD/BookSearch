//
//  SearchViewModel.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import Foundation
import Observation

@Observable
class SearchViewModel {
    var searchQuery = ""
    var books: [Book] = []
    var isLoading = false
    var errorMessage = ""
    var showError = false

    func searchBooks() async {
        isLoading = true
        showError = false

        do {
            let results = try await BookAPIService.shared.searchBooks(query: searchQuery)
            books = results
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            showError = true
            isLoading = false
        }
    }
}
