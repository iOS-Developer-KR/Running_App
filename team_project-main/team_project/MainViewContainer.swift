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
    @StateObject var soundManager: MusicPlayer = MusicPlayer()
//    @EnvironmentObject private var connect: iOSToWatch
    @State private var pressed: Bool = false

    // MARK: - FUNCTIONS

    // MARK: - BODY
    
    var body: some View {
        VStack {
            HeaderView()
            UserInfoViewContainer()
            MyRoutineView()
            
            Button {
//                soundManager.getTest(url: Constants().currentmusic!)
                Task {
//                    DispatchQueue.main.async {
//                    soundManager.setupRemoteCommands()
                    soundManager.getTest(url: Constants().currentmusic!)
//                    }
                }
                
            } label: {
                Text("노래 시작")
            }

            Button {
                soundManager.playSound()
            } label: {
                Text("ㄴㄹ오내로내로")
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


#Preview {
    MainViewContainer(soundManager: MusicPlayer())
//        .environmentObject(iOSToWatch())
}

