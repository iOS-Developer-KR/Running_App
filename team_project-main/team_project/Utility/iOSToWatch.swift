//
//  iOSToWatch.swift
//  team_project
//
//  Created by Taewon Yoon on 3/15/24.
//

import Foundation
import WatchConnectivity

class iOSToWatch: NSObject, ObservableObject {
    static let sharedManager = iOSToWatch()
    @Published var startStatus: Bool?
    @Published var bpm: Int?

    override init() {
        super.init()
        if WCSession.isSupported() {
            print("시작")
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("페어링 여부:\(session.isPaired)")
            print("애플워치 앱 설치 여부:\(session.isComplicationEnabled)")
        }
    }
    
    func check() {
        let session = WCSession.default
        print("페어링 여부:\(session.isPaired)")
    }
    
    func sendMessage(message: [String:Any]) {
        let session = WCSession.default
        session.sendMessage(message) { _ in
            
        }
    }
}

extension iOSToWatch: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("세션이 활성화되었다")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("세션이 비활성화되었다")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("WCSession activated successfully")
        case .inactive:
            print("Unable to activate the WCSession. Error: \(error?.localizedDescription ?? "--")")
        case .notActivated:
            print("Unexpected .notActivated state received after trying to activate the WCSession")
        @unknown default:
            print("Unexpected state received after trying to activate the WCSession")
        }
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // 파일 타입으로 받았을 때
    }
    

    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        // 데이터 타입으로 받았을 떄
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let startValue = message["heartRate"] {
            DispatchQueue.main.async {
                self.bpm = startValue as? Int
            }
        }
        if let startValue = message["start"] {
            DispatchQueue.main.async {
                self.startStatus = startValue as? Bool
            }
        }
    }
    
    
}
