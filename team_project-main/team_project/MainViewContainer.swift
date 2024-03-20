//
//  MainView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/28/23.
//

import SwiftUI
import AVFAudio

struct MainViewContainer: View {
    
    // MARK: - PROPERTIES
    //    @StateObject var soundManager: MusicPlayer = MusicPlayer() // 되는거
    @EnvironmentObject var soundManager: MusicPlayer
    
    //    @EnvironmentObject private var connect: iOSToWatch
    @State private var pressed: Bool = false
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                VStack {
                    HeaderView()

                    UserInfoViewContainer()
                    
                    MainViewMusicContainer()
                    Spacer()
                    
                    HStack(alignment:.bottom) {
                        Text("내 루틴")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    
                    HStack {
                        MyRoutineView()
                        Spacer()
                    }
                    
                    Button {
                        soundManager.getTest(url: Constants().currentmusic!)
                    } label: {
                        Text("노래 시작")
                    }
                    
                    Spacer()
                    
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            pressed.toggle()
                        }, label: {
                            Text("루틴추가")
                        })
                        .foregroundStyle(.white)
                        .padding(20)
                    }
                }.sheet(isPresented: $pressed, content: {
                    AddingRoutineView()
                })
            }
        }
//        .overlay(alignment: .bottomTrailing) {
//
//        }
        
        
    }
}


#Preview {
    MainViewContainer()
        .modelContainer(PreviewContainer.container)
    
    //    MainViewContainer(soundManager: MusicPlayer())
    //        .environmentObject(iOSToWatch())
}

