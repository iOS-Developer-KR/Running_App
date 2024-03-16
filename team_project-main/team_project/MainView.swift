//
//  MainView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/28/23.
//

import SwiftUI
import CoreBluetooth
import Combine
import AVFAudio
import Alamofire
import JWTDecode

struct test: Decodable {
    var token: String
}
struct MainView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var bluetooth: Bluetooth
    @StateObject private var soundManager = MusicPlayer()
    @EnvironmentObject private var connect: iOSToWatch
    
    // MARK: - FUNCTIONS

    // MARK: - BODY
    
    var body: some View {
        VStack {
            Text("연결상태:" + (connect.startStatus?.description ?? ""))
            Text("심박수:" + (connect.bpm?.description ?? ""))
            
            HStack {
                Button {
//                    connect.sendMessage(message: ["start":true])
                    soundManager.playSound()
                } label: {
                    Text("음악시작")
                }
                
                Button {
                    connect.sendMessage(message: ["start":false])
                } label: {
                    Text("종료")
                }
            }
            
            HStack {
                Button {
                    print("심박수 요청버튼 눌렀다")
                    connect.sendMessage(message: ["heart":true])
                } label: {
                    Text("심박수 가져오기")
                }

            }
            
            Spacer()
            
        }
        .onAppear {
            
//            Task {
//                await soundManager.readyToConnect(url: Constants().currentmusic!)
//            }
            
        }
    }
}


//#Preview {
//    MainView()
//}

