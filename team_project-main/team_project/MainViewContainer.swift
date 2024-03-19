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
            
            VStack {
                HeaderView()
                UserInfoViewContainer()
                MyRoutineView()
                
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
                    .buttonBorderShape(.roundedRectangle)
                    .foregroundStyle(.green)
                }.padding()
            }.sheet(isPresented: $pressed, content: {
                AddingRoutineView()
            })
            .onAppear {
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try? AVAudioSession.sharedInstance().setActive(true)
            }
        }
        
    }
}


#Preview {
    MainViewContainer()

//    MainViewContainer(soundManager: MusicPlayer())
//        .environmentObject(iOSToWatch())
}

