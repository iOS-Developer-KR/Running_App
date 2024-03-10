//
//  SplashScreenView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/17/23.
//
import SwiftUI
import JWTDecode
import Foundation
import AVFAudio

struct SplashScreenView: View {
    // MARK: - PROPERTIES
    @State private var isLoggedIn: Bool = false
    @State private var credentials: Credentials?
    @State private var token: String?
    @EnvironmentObject var isLogged: LoginStatus
    let loginmodel = LoginModel()
    
    // MARK: - FUNCTIONS
    func MainTainSession() {
        DispatchQueue.main.async {
            do {
                if try KeyChain.CheckToken() { // 토큰이 존재하는데 유효하지 않는다면
                    loginmodel.Relogin { result in
                        if result {
                            isLogged.isLogged = true
                        } else {
                            isLogged.isLogged = false
                        }
                    }
                } else { // 토큰이 존재하는데 유효한다면  // 바로 메인 화면으로 넘어가기
                    print("토큰이 유효하다고?")
                    isLogged.isLogged = true
                }
            } catch KeychainError.notFound {
                isLogged.isLogged = false
            } catch {
                print(error)
                isLogged.isLogged = false
            }
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            // Splash 화면 디자인
            Text("Your App Splash Screen")
                .onAppear { // Splash 화면에서 비동기 작업 수행
                    Task { // 토큰 만료 여부 확인 후 만료되었으면 자동 로그인 진행
                        MainTainSession()
                        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                        try? AVAudioSession.sharedInstance().setActive(true)
                    }
                }
        }
    }
    
    
}

#Preview {
    SplashScreenView()
}
