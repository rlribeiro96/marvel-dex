//
//  MarvelDexApp.swift
//  MarvelDex
//
//  Created by Ricardo Ribeiro on 17/04/24.
//

import SwiftUI

@main
struct MarvelDexApp: App {

    var body: some Scene {
        WindowGroup {
            Group {
                TabView {
                    CharactersListView(viewModel: CharactersListViewModel())
                        .tabItem {
                            Label("Characters", systemImage: "figure.archery")
                        }
                    BookmarksView(viewModel: BookmarksViewModel())
                        .tabItem {
                            Label("Bookmarks", systemImage: "heart")
                                .tint(.red)
                        }
                }.onAppear {
                    if #available(iOS 15.0, *) {
                        let appearance = UITabBarAppearance()
                        UITabBar.appearance().scrollEdgeAppearance = appearance
                    }
                }
            }.onAppear {
                CryptoManager.getKeys()
            }
        }
    }
}
