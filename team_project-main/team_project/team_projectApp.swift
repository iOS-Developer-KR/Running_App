//
//  team_projectApp.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI
import CoreData
import AVFoundation
import SwiftData

@main

struct team_projectApp: App {
    var loginmodel = LoginModel()
    @StateObject var isLogged = LoginStatus()
    @StateObject var timeManager = TimerManager()
    @State private var isSplashScreenVisible = true
//    @StateObject var connectManager = iOSToWatch()
    @Environment(\.scenePhase) var scenePhase
    @StateObject var musicPlayer = MusicPlayer()
    
    // MARK: - FUNCTIOINS
    func MainTainSession() {
        DispatchQueue.main.async {
            do {
                KeyChain.CheckToken { result in
                    switch result {
                    case .success(true):
                        loginmodel.Relogin2 { result in
                            if result {
                                self.isLogged.isLogged = true
                            } else {
                                self.isLogged.isLogged = false
                            }
                        }
                    case .success(false):
                        self.isLogged.isLogged = true
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    
    var body: some Scene {
        WindowGroup {

            ContentView()
//                .environment(\.managedObjectContext, ApplicationData.preview.container.viewContext)
                .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseRecordContainer.self, ExerciseDefaultModel.self , ExerciseRecordModel.self])//,  ExerciseModel.self])
//                .modelContainer(for: ExerciseDataModel.self)
                .environmentObject(musicPlayer) // 3월19일날 추가한거
                .environmentObject(timeManager)

            }
        }
    
    
//    var body: some Scene {
//        WindowGroup {
//            ZStack {
//                if isSplashScreenVisible {
//                    SplashScreenView()
//                        .onAppear {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                withAnimation {
//                                    isSplashScreenVisible = false
//                                }
//                            }
//                        }
//                } else {
//                    if isLogged.isLogged {
//                        ContentView()
//                            .modelContainer(for: [Exercise.self])
//                            .environmentObject(musicPlayer) // 3월19일날 추가한거
//                    } else { // 만일 로그인이 실패한 상태라면
//                        LoginRegisterView()
//                    }
//                }
//            }
//        }
//        .environmentObject(isLogged)
//        .onChange(of: scenePhase) {
////                do {
////                    try KeyChain.delete()
////                } catch {
////                    print("키체인 지우기 실패")
////                }
//            MainTainSession()
//        }
//    }
}

