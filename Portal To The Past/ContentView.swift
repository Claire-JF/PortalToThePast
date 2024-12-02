//
//  ContentView.swift
//  Portal To The Past
//
//  Created by Weitian on 2024-11-20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            GameView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }
            
            PanoramaView()
                .tabItem {
                    Label("Panorama", systemImage: "photo")
                }
        }
        .accentColor(AppTheme.shared.colors.olive)
    }
}

#Preview {
    ContentView()
}
