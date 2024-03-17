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
    @State private var pressed: Bool = false

    // MARK: - FUNCTIONS

    // MARK: - BODY
    
    var body: some View {
        VStack {
            HeaderView()
            UserInfoViewContainer()
            MyRoutineView()
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    pressed.toggle()
                }, label: {
                    Text("루틴추가")
                })
                .buttonBorderShape(.roundedRectangle)
                .foregroundStyle(.green)
            }.padding()
        }.sheet(isPresented: $pressed, content: {
            AddingRoutineView()
        })
        
    }
}


#Preview {
    MainViewContainer()
        .environmentObject(iOSToWatch())
}

