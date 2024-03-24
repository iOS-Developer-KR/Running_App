//
//  LoginView2.swift
//  team_project
//
//  Created by Taewon Yoon on 11/6/23.
//

import SwiftUI

enum tapInfo : String, CaseIterable {
    case login = "로그인"
    case register = "회원가입"
}

struct LoginRegisterView: View {

    @State private var selectedPicker: tapInfo = .login
    @State private var moving = 0
    @State private var rotate = false
    @State private var roll = false
    @Namespace private var animation
    
    var body: some View {
        GeometryReader { geo in

            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(uiColor: .darkGray), Color(uiColor: .black)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .opacity(1)
                VStack {
                    Image("gym.icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .offset(x: rotate ? 0 : geo.size.width / 2)
                        .rotation3DEffect(
                            .degrees(roll ? 0 : 180),
                                axis: (x: 40.0, y: 700.0, z: 100.0)
                        )
                        .onAppear(perform: {
                            withAnimation(.easeOut(duration: 1.5)) {
                                rotate = true
                            }
                            withAnimation(.linear(duration: 1.5)) {
                                roll = true
                            }
                        })
                        
                    
                    Text("The Smart Mirror")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                        .bold()
                    
                    animate()
                    testView(tests: selectedPicker)
                }
            }

        }
    }
    
    @ViewBuilder
    private func animate() -> some View {
        HStack {
            ForEach(tapInfo.allCases, id: \.self) { item in
                VStack {
                    Text(item.rawValue)
                        .font(.title3)
                        .frame(maxWidth: .infinity/4, minHeight: 50)
                        .foregroundColor(selectedPicker == item ? .white : .gray)

                    if selectedPicker == item {
                        Capsule()
                            .foregroundColor(.black)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "info", in: animation)
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.selectedPicker = item
                    }
                }
            }
        }
    }
}

struct testView : View {
    
    var tests : tapInfo
    
    var body: some View {
        
        switch tests {
        case .login:
            LoginView()
        case .register:
            RegisterationView()
                
        }
    }
}
#Preview {
    LoginRegisterView()
}
