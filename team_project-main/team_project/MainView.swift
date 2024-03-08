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

struct MainView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var bluetooth: Bluetooth
    @StateObject private var soundManager = MusicPlayer()
    @State private var textfield = ""
    @State private var alert = false
    var cancellable: Cancellable?
//    var player = MusicPlayer.instance
    
    // MARK: - FUNCTIONS
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                bluetooth.connected ? Image(systemName: "antenna.radiowaves.left.and.right") : Image(systemName: "antenna.radiowaves.left.and.right.slash")
            }.padding()
            
            VStack {
                Text(bluetooth.values)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Text(bluetooth.connectedPeripheral?.state.rawValue.description ?? "")
            }
            
            VStack {
                HStack {
                    Button(action: {
                        bluetooth.stopScan()
                    }) {
                        Text("스캔중단")
                    }
                    
                    Button(action: {
                        bluetooth.startScan()
                    }) {
                        Text("스캔시작")
                    }
                    
                }.padding(20)
                
                Spacer()
                
                TextField(text: $textfield, prompt: Text("전송할값")) {
                    Text("텍스트필드")
                }.padding()
                
                HStack {
                    Button {
                        // 데이터를 보내기 전에 연결상태를 먼저 확인해야 한다
                        if !bluetooth.sendMessageToDevice("o") {
                            alert = true
                        }
                    } label: {
                        Text("불켜기")
                    }.padding()
                    Button {
                        if !bluetooth.sendMessageToDevice("f") {
                            alert = true
                        }
                    } label: {
                        Text("불끄기")
                    }.padding()
                }
                Spacer()
                
                HStack {
                    Button {
                        Task {
                            if try !KeyChain.CheckToken() { // 만약 만료되지 않았다면
                                await soundManager.getMusicInfo(url: Constants().currentmusic!)
                            }
//                            soundManager.playing()
                        }
                    } label: {
                        Text("노래켜기")
                    }
                    
                    Button {
                        soundManager.stopSound()
                    } label: {
                        Text("노래끄기")
                    }
                    
                }
            }
            
            List(bluetooth.peripherals.sorted(by: { $0.readRSSI() < $1.readRSSI() }), id: \.self) { ph in
                if let name = ph.name {
                    Button {
                        bluetooth.centralManager.connect(ph)
                    } label: {
                        Text(name)
                    }
                }
            }
            
            Spacer()
            
        }
        .alert("연결 실패", isPresented: $alert){
            Button("블루투스 연결을 확인하세요") { alert = false }
        }
        .onAppear {
            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try? AVAudioSession.sharedInstance().setActive(true)
//            Task {
//                await soundManager.readyToConnect(url: Constants().currentmusic!)
//            }
        }
    }
}


//#Preview {
//    MainView()
//}

extension CBPeripheral: Identifiable {
}
