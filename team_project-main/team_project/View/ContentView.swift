//
//  ContentView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appear = false
    var loginmodel = LoginModel()
    @AppStorage("id") var userid = ""
    @State private var credentials: Credentials?
    @StateObject var bluetooth = Bluetooth()


    // MARK: - FUNCTIONS

    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                }
                .environmentObject(bluetooth)
            SummeryView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                }
            
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
