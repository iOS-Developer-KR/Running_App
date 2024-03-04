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
    
    func getCredentials() -> Credentials? {
        do {
            print("확인하기")
            credentials = try KeyChain.get() // 키체인이 있는지 확인합니다.
            return credentials
        } catch KeychainError.notFound {
            print("존재하지 않는다")
            isLogged.checklogged(logged: false)
            return nil
        } catch {
            print("토큰 가져오기에러:\(error.localizedDescription)")
            isLogged.checklogged(logged: false)
            return nil
        }
    }
    
    // 비동기로 자동 로그인 시도
    private func attemptAutoLogin() {
        // 여기에서 자동 로그인 로직을 구현
        // 토큰이 유효하지 않은 상태라면 기존 로그인 정보로 재접속
        do {
            if try KeyChain.CheckToken() {
                loginmodel.Relogin(completion: { result in
                    if result { // 재로그인을 다시 시도했을때 성공할 경우
                        print("재로그인 성공 -> ContentView로 이동해야한다")
                        DispatchQueue.main.async {
                            isLogged.checklogged(logged: true)
                        }
                    } else { // 재로그인을 실패했을때 로그인창으로 회원정보 재입력
                        print("재로그인 실패 -> 로그인뷰로 이동해야한다")
                        DispatchQueue.main.async {
                            isLogged.checklogged(logged: false)
                        }
                    }
                })
            } else { isLogged.checklogged(logged: false) }
        } catch {
            print("에러 발생:\(error)")
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            // Splash 화면 디자인
            Text("Your App Splash Screen")
                .onAppear { // Splash 화면에서 비동기 작업 수행
                    Task { // 토큰 만료 여부 확인 후 만료되었으면 자동 로그인 진행
                        attemptAutoLogin()
                    }
                }
        }
    }
    
    
}

#Preview {
    SplashScreenView()
}
