//
//  team_projectApp.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

@main

struct team_projectApp: App {
    var loginmodel = LoginModel()
    @StateObject var isLogged = LoginStatus()
    @State private var isSplashScreenVisible = true
    @Environment(\.scenePhase) var scenePhase
    
    // MARK: - FUNCTIOINS
    func MainTainSession() {
//        do {
//            if try KeyChain.CheckToken() { // 토큰이 존재하는데 유효하지 않는다면
                loginmodel.Relogin { result in
                    if result {
                        isLogged.isLogged = true
                    } else {
                        isLogged.isLogged = false
                    }
                }
//            } else { // 토큰이 존재하는데 유효한다면  // 바로 메인 화면으로 넘어가기
//                isLogged.isLogged = true
//            }
//        } catch {
//            print(error)
//            isLogged.isLogged = false
//        }
    }
    
    // MARK: - FUNCTIONS
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isSplashScreenVisible {
                    SplashScreenView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    isSplashScreenVisible = false
                                }
                            }
                        }
                } else {
                    if let views = isLogged.isLogged {
                        if views { // 만약 로그인 성공이라면
                            ContentView()
                        } else { // 만일 로그인이 실패한 상태라면
                            LoginRegisterView()
                        }
                    }
                }
            }
        }
        .environmentObject(isLogged)
        .onChange(of: scenePhase) {
//                                    do {
//                                        try KeyChain.delete()
//                                    } catch {
//                                        print("키체인 지우기 실패")
//                                    }
            //                        getCredentials()
            MainTainSession()
            //            MainView()
            //                .environmentObject(bluetooth)
        }
    }
}

