//
//  RegisterationView.swift
//  MySQLApp
//
//  Created by Taewon Yoon on 2023/09/07.
//

import SwiftUI

struct RegisterationView: View {
    
    // MARK: - PROPERTY
    var model = RegisterModel()

    @State private var id: String = ""
    @State private var password: String = ""
    @State private var alert = false
    @State private var response: RegisterResponseDTD?

    let inputWidth: CGFloat = UIScreen.main.bounds.width / 1.6
    
    private var isFormValid: Bool {
        !id.isEmpty && !password.isEmpty && (password.count >= 6 && password.count <= 10)
    }
    
    
    private let httpClient = HTTPClient()
    
    // MARK: - FUNCTION
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(uiColor: .darkGray), Color(uiColor: .black)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(1)
            
            VStack(alignment: .center, spacing: 20) {
                
                IdView(id: $id)
                PasswordView(password: $password)
                
                Button(action: {
                    Task {
                        print("값 보냄")
                        model.registers(userid: id, password: password) { result in
                            switch result {
                            case .success(let data):
                                // 성공적으로 데이터를 받아왔을 때의 처리
                                print("Received response: \(data)")
                                response = data
                            case .failure(let error):
                                // 실패했을 때의 처리
                                print("Error occurred: \(error)")
                            }

                            
                        }
//                        response = await model.register(userid: id, password: password)
//                        if response?.error == true {
//                            print("실패")
//                            alert.toggle()
//                        } else {
//                            print("성공")
//                            // 다음 화면으로 넘어가기
//                        }
                    }
                }, label: {
                    Text("회원가입")
                        .font(.system(size: 20))
                        .fontWeight(.light)
                        .frame(height: 2)
                })
                .buttonStyle(GradientBackgroundStyle())
                .padding()
                .disabled(!isFormValid)
                
                Spacer()
            } // VSTACK
            .navigationTitle("회원가입")
            .alert(response?.reason ?? "", isPresented: $alert) {
                Button("확인", role: .cancel) { }
            }
            .padding()
        }
        .padding()

    }
}

struct RegisterationView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterationView()
    }
}


////
////  RegisterationView.swift
////  MySQLApp
////
////  Created by Taewon Yoon on 2023/09/07.
////
//
//import SwiftUI
//
//struct RegisterationView: View {
//    
//    // MARK: - PROPERTY
//    var model = RegisterModel()
//
//    @State private var id: String = ""
//    @State private var password: String = ""
//    @State private var key: String = ""
//    @State private var alert = false
//    @State private var response: RegisterResponseDTD?
//    @Binding var path: [String]
//
//    let inputWidth: CGFloat = UIScreen.main.bounds.width / 1.6
//    
//    private var isFormValid: Bool {
//        !id.isEmpty && !password.isEmpty && (password.count >= 6 && password.count <= 10)
//    }
//    
//    
//    private let httpClient = HTTPClient()
//    
//    // MARK: - FUNCTION
//    
////    private func register() async {
////        
////            print("타입체크:\(type(of: id)), \(type(of: password))")
////        let response = await model.register(userid: id, password: password, key: key)
////        if response.error {
////            alert.toggle()
////        } else {
////            // 다음 화면으로 넘어가기
////        }
////
////    }
//    
//    // MARK: - BODY
//    
//    var body: some View {
//        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color(uiColor: .darkGray), Color(uiColor: .black)]), startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
//                .opacity(1)
//            
//            VStack(alignment: .center, spacing: 20) {
//                Spacer()
//                
//                //            Button(action: {
//                //                Task {
//                //                    keys = model.sends()
//                //                }
//                //            }, label: {
//                //                Text("Button")
//                //            })
//                HStack {
//                    Image(systemName: "key.radiowaves.forward.fill")
//                        .foregroundStyle(.gray)
//                    
//                    TextField("", text: $key, prompt: Text("인증키").foregroundStyle(.gray))
//                        .foregroundStyle(.white)
//                        .padding(.horizontal, 6)
//                        .border(.blue, width: 1)
//                        .frame(width: inputWidth, alignment: .center)
//                        .textInputAutocapitalization(.never) // 첫문자 대문자 안되게 해준다.
//                        .autocorrectionDisabled()
//                }
//                IdView(id: $id, inputWidth: inputWidth)
//                
//                PasswordView(password: $password, inputWidth: inputWidth)
//                
//                Button {
//                    Task {
//                        response = await model.register(userid: id, password: password, key: key)
//                        if ((response?.error) != nil) {
//                            alert.toggle()
//                        } else {
//                            // 다음 화면으로 넘어가기
//                            path.removeLast()
//                        }
//                    }
//                } label: {
//                    Text("회원가입")
//                        .font(.system(size: 20))
//                        .fontWeight(.light)
//                        .foregroundColor(.accentColor)
//                    
//                }
//                .padding()
//                .disabled(!isFormValid)
//                
//                Spacer(minLength: 300)
//            }
//            .navigationTitle("회원가입")
//            .alert(response?.reason ?? "", isPresented: $alert) {
//                Button("확인", role: .cancel) { }
//            }
//        }
//
//    }
//}
//
//struct RegisterationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterationView( path: .constant(["dd"]))
//    }
//}
