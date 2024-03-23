//
//  ContentView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appear = false


    // MARK: - FUNCTIONS

    var body: some View {
        TabView {
            MainViewContainer()
                .tabItem {
                    Image(systemName: "house")
                }
            
            TextView()
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .scaleEffect(appear ? 1 : 0)
        .onAppear {
            withAnimation(.easeOut) {
                appear = true
            }
        }
        
    }
}

#Preview {
    ContentView()
}
