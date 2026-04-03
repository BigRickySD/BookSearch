//
//  BookRowView.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//


import SwiftUI

struct BookRowView: View {
    var book: Book
    var isFavorite: Bool
    var onTapFavorite: () -> Void

    var body: some View {
        HStack {
            AsyncImage(url: book.coverURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "book.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .padding(8)
            }
            .frame(width: 50, height: 70)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(4)

            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)

                Text(book.authors.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)

                if let publisher = book.publisher {
                    Text(publisher)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }

            Spacer()

            Button(action: onTapFavorite) {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(.red)
                    .font(.title3)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 4)
    }
}