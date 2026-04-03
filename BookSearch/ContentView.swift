//
//  ContentView.swift
//  BookSearch
//
//  Created by Ricky Bryce on 4/3/26.
//

import SwiftUI

struct ContentView: View {
    @State private var favoritesViewModel = FavoritesViewModel()
    @State private var selectedTab = 0

    var body: some View {
        ZStack {
            SearchView()
                .opacity(selectedTab == 0 ? 1 : 0)
                .allowsHitTesting(selectedTab == 0)

            FavoritesView()
                .opacity(selectedTab == 1 ? 1 : 0)
                .allowsHitTesting(selectedTab == 1)
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    selectedTab = 0
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 22))
                        Text("Search")
                            .font(.caption2)
                    }
                    .foregroundStyle(selectedTab == 0 ? Color.blue : Color.gray)
                }

                Spacer()

                Button {
                    selectedTab = 1
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 22))
                        Text("Favorites")
                            .font(.caption2)
                    }
                    .foregroundStyle(selectedTab == 1 ? Color.blue : Color.gray)
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(
                Color(uiColor: .systemBackground)
                    .ignoresSafeArea(edges: .bottom)
                    .shadow(color: .gray.opacity(0.2), radius: 0, x: 0, y: -1)
            )
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 0.5)
            }
        }
        .environment(favoritesViewModel)
    }
}
