//
//  SplashScreenView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/17/23.
//
import SwiftUI
import JWTDecode
import Foundation

struct SplashScreenView: View {
    // MARK: - PROPERTIES
    @State private var isLoggedIn: Bool = false
    @State private var credentials: Credentials?
    @State private var token: String?
    @EnvironmentObject var isLogged: LoginStatus
    let loginmodel = LoginModel()
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            // Splash 화면 디자인
            Text("Your App Splash Screen")
                .onAppear { // Splash 화면에서 비동기 작업 수행
                    Task { // 토큰 만료 여부 확인 후 만료되었으면 자동 로그인 진행
//                        loginmodel.attemptAutoLogin()
                    }
                }
        }
    }
    
    
}

#Preview {
    SplashScreenView()
}
