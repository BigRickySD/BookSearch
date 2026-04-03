//
//  BookAPIService.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//


import Foundation

class BookAPIService {
    static let shared = BookAPIService()

    func searchBooks(query: String) async throws -> [Book] {
        let fixedQuery = query.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://openlibrary.org/search.json?q=\(fixedQuery)&limit=20&fields=key,title,author_name,publisher,cover_i"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SearchResponse.self, from: data)
        let books = response.docs.map { $0.toBook() }
        return books
    }

}