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
    @EnvironmentObject var timer: TimerManager
    
    //    @EnvironmentObject private var connect: iOSToWatch
    @State private var pressed: Bool = false
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
//            ScrollView {
                
                VStack {
                    HeaderView()

                    UserInfoViewContainer()
                    
                    MainViewMusicContainer()
                    
                    HStack(alignment:.bottom) {
                        Text("내 루틴")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    
                    
                    MyRoutineView()
                    
                    // 만약 타이머가 작동중이라면 하단에 현재 시간을 나타낸다.
                    if timer.checking {
                        
                        NavigationLink {
                            if let data = timer.exerciseRoutineContainer {
                                RoutineListView(exerciseContainer: data)
                            }
                        } label: {
                            TimerView()
                        }

                        
                    } else {
                        HStack { // 만약 타이머가 작동중이라면 안보이게한다
                            Spacer()
                            Button(action: {
                                pressed.toggle()
                            }, label: {
                                Text("루틴추가")
                            })
                            .foregroundStyle(.white)
                            .padding(20)
                        }
                    }
                }.sheet(isPresented: $pressed, content: {
                    AddingRoutineView()
                })
            }
        .onAppear {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try? AVAudioSession.sharedInstance().setActive(true)
        }
//        }

        
        
    }
}


#Preview {
    MainViewContainer()
        .modelContainer(PreviewContainer.container)
        .environmentObject(TimerManager())
    
    //    MainViewContainer(soundManager: MusicPlayer())
    //        .environmentObject(iOSToWatch())
}

