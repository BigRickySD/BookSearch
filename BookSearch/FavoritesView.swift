//
//  FavoritesView.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import SwiftUI

struct FavoritesView: View {
    @Environment(FavoritesViewModel.self) private var favoritesViewModel
    @Environment(\.editMode) private var editMode

    var body: some View {
        NavigationStack {
            List {
                ForEach(favoritesViewModel.favoriteBooks) { book in
                    BookRowView(
                        book: book,
                        isFavorite: true,
                        onTapFavorite: {
                            favoritesViewModel.removeFavorite(book: book)
                        }
                    )
                }
                .onDelete(perform: favoritesViewModel.deleteFromList)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Favorites")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(editMode?.wrappedValue == .active ? "Done" : "Edit") {
                        withAnimation {
                            editMode?.wrappedValue = editMode?.wrappedValue == .active ? .inactive : .active
                        }
                    }
                    .foregroundStyle(.blue)
                }
            }
            .onAppear {
                favoritesViewModel.loadFavorites()
            }
        }
    }
}
