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
                    
                    Spacer()
                    
                    HStack(alignment:.bottom) {
                        Text("내 루틴")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    
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
//            .navigationTitle("홈")
//            .navigationBarTitleDisplayMode(.large)
        }
        
        
    }
}


#Preview {
    MainViewContainer()
        .modelContainer(PreviewContainer.container)
    
    //    MainViewContainer(soundManager: MusicPlayer())
    //        .environmentObject(iOSToWatch())
}

