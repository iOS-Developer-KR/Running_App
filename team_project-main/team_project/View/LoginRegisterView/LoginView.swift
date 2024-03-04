//
//  LoginView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - PROPERTY
    var registermodel = RegisterModel()
    var loginmodel = LoginModel()
    
    private let httpClient = HTTPClient()
    
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var key: String = ""
    @State private var alert = false
    @EnvironmentObject var isLogged: LoginStatus
    @AppStorage("login") var login = false
    
    // MARK: - FUNCTIONS
    

    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(uiColor: .darkGray), Color(uiColor: .black)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(1)
            
            VStack(alignment: .center, spacing: 20) {
                
                IdView(id: $id)
                PasswordView(password: $password)
                
                HStack(spacing: 20) {
                    Button {
                        print("로그인")
                        Task {
//                            loginmodel.ReLogin()
                            loginmodel.login(userid: id, password: password) { result in
                                if result {
                                    print("로그인됐는데?")
                                    isLogged.checklogged(logged: true)
                                } else {
                                    print("로그인 안됐는데?")
                                    alert.toggle()
                                }
                            }
                        }
                    } label: {
                        Text("로그인")
                            .font(.system(size: 20))
                            .fontWeight(.light)
                            .frame(height: 2)
                    }.buttonStyle(GradientBackgroundStyle())
                    
                } // HSTACK
                
                Spacer()
            } // VSTACK
            .navigationDestination(for: String.self, destination: { str in
                if str == "회원가입" {
                    RegisterationView()
                }
            }) // navigationDestination
            .alert("로그인이 안됐습니다", isPresented: $alert) {
                Button("확인", role: .cancel) { }
            }
            .padding()
            
        } // ZSTACK
        .padding()
    } // ZSTACK
    
}// BODY

struct GradientBackgroundStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}


#Preview {
    LoginView()
}
//
//struct LoginViewFunctions: Hashable {
//    let name: String
//}


////
////  LoginView.swift
////  team_project
////
////  Created by Taewon Yoon on 10/31/23.
////
//
//import SwiftUI
//
//struct LoginView: View {
//
//    // MARK: - PROPERTY
//    var model = RegisterModel()
//    private let httpClient = HTTPClient()
//
//    @State private var id: String = ""
//    @State private var password: String = ""
//    @State private var key: String = ""
//    @State private var alert = false
//    @State private var response: RegisterResponseDTD?
//    @State private var path: [String] = []
//    @AppStorage("login") var login = false
//    //    @State private var paths: NavigationPath
//
//    let inputWidth: CGFloat = UIScreen.main.bounds.width / 1.6
//
//
//    var buttons: [LoginViewFunctions] = [.init(name: "로그인"), .init(name: "회원가입"), .init(name: "아이디 찾기"), .init(name: "비밀번호 찾기")]
//
//
//    // MARK: - BODY
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            ZStack {
//                LinearGradient(gradient: Gradient(colors: [Color(uiColor: .darkGray), Color(uiColor: .black)]), startPoint: .top, endPoint: .bottom)
//                    .ignoresSafeArea()
//                    .opacity(1)
//
//
//                VStack(alignment: .center, spacing: 20) {
//                    Spacer()
//                    Image("gym.icon")
//                        .resizable()
//                        .scaledToFit()
//                        .symbolRenderingMode(.palette)
//                        .foregroundStyle(.green, .gray)
//                        .frame(width: 100, height: 100)
//
//                    IdView(id: $id, inputWidth: inputWidth)
//
//                    PasswordView(password: $password, inputWidth: inputWidth)
//
//                    HStack(spacing: 20) {
//                        Button {
//                            print("로그인")
//                            Task {
//                                print("체크111")
////                                                        await self.login()
////                                                        model.isLoggedIn = true
//                                print("체크222")
//                                login = true
//                            }
//                        } label: {
//                            Text("로그인")
//                                .font(.system(size: 20))
//                                .fontWeight(.light)
//                                .frame(height: 2)
//                        }.buttonStyle(GradientBackgroundStyle())
//
//                        NavigationLink(value: buttons[1], label: {
//                            Button(action: {
//                                print("회원가입 추가")
//                                path.append("회원가입")
//                            }, label: {
//                                Text("회원가입")
//                                    .font(.system(size: 20))
//                                    .fontWeight(.light)
//                                    .frame(height: 2)
//                            }).buttonStyle(GradientBackgroundStyle())
//                        })
//
//
//                    } // HSTACK
//
//                    Spacer(minLength: 300)
//                } // VSTACK
//                .navigationDestination(for: String.self, destination: { str in
//                    if str == "회원가입" {
//                        RegisterationView(path: $path)
//                    }
//                }) // navigationDestination
//            } // HSTACK
//
//        } // ZSTACK
//
//    }// BODY
//}
//
//struct GradientBackgroundStyle: ButtonStyle {
//
//    func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .padding()
//            .foregroundColor(.white)
////            .background(.gray)
//            .background(LinearGradient(gradient: Gradient(colors: [Color(.red), Color(.yellow)]), startPoint: .leading, endPoint: .bottomTrailing))
//            .clipShape(RoundedRectangle(cornerRadius: 25))
//            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
//    }
//}
//
//
//#Preview {
//    LoginView()
//}
//
//struct LoginViewFunctions: Hashable {
//    let name: String
//}
