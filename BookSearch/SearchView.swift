//
//  SearchView.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import SwiftUI

struct SearchView: View {
    @State private var viewModel = SearchViewModel()
    @Environment(FavoritesViewModel.self) private var favoritesViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    TextField("Search books...", text: $viewModel.searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            Task { await viewModel.searchBooks() }
                        }

                    Button {
                        Task { await viewModel.searchBooks() }
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .disabled(viewModel.searchQuery.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Searching...")
                    Spacer()
                } else if viewModel.showError {
                    Spacer()
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    List(viewModel.books) { book in
                        BookRowView(
                            book: book,
                            isFavorite: favoritesViewModel.isFavorite(book: book),
                            onTapFavorite: {
                                favoritesViewModel.toggleFavorite(book: book)
                            }
                        )
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Book Search")
        }
    }
}
