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
    @State private var textfield = ""
    @State private var alert = false
    var cancellable: Cancellable?
//    var player = MusicPlayer.instance
    
    // MARK: - FUNCTIONS

//    func login() async {
//        do {
//            let loginData = ["username": "lsh", "password": "lsh"]
//            var request = try URLRequest(url: URL(string: "http://lsproject.shop:8080/api/login")!, method: .post)
//            request.httpBody = try? JSONEncoder().encode(loginData)
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            let configuration = URLSessionConfiguration.default
//            configuration.urlCache = URLCache.shared
//            configuration.requestCachePolicy = .returnCacheDataElseLoad
//            let session = URLSession(configuration: configuration)
//            print("웹으로부터 가져오기전 \(Date().timeIntervalSince1970)")
//            let (data, _) = try await session.data(for: request)
//            let test = try JSONDecoder().decode(test.self, from: data)
//            print(test.token)
//            configuration.urlCache = nil
//            configuration.requestCachePolicy = .useProtocolCachePolicy
//            print(JWT().decodeJWTPart(test.token))
//            print(JWT().decode_header(jwtToken: test.token))
//            print(JWT().decode_payload(jwtToken: test.token))
//            print(JWT().decode_signature(jwtToken: test.token))
//        } catch {
//            
//        }
//    }
    
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
                        do {
                            if try !KeyChain.CheckToken() {
                                Task {
                                    await soundManager.getMusicFromServer()
                                }
                            }
                        } catch {
                            print(error)
                        }
                    } label: {
                        Text("fetch")
                    }
                    
                    Button {

//                        soundManager.stopSound()
                        
//                        do {
//                            let data = try KeyChain.get()
//                            print(data.token)
//                        } catch {
//                            
//                        }
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
