//
//  MainView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/28/23.
//

import SwiftUI

struct MainViewContainer: View {
    
    // MARK: - PROPERTIES
    @StateObject private var soundManager = MusicPlayer()
    @EnvironmentObject private var connect: iOSToWatch
    
    // MARK: - FUNCTIONS

    // MARK: - BODY
    
    var body: some View {
        VStack {
            HeaderView()
            UserInfoViewContainer()
            
            Spacer()
        }
        
    }
}


#Preview {
    MainViewContainer()
        .environmentObject(iOSToWatch())
}

