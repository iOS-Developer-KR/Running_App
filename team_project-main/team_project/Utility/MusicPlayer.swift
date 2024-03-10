//
//  MusicPlayer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/2/24.
//

import AVFoundation
import MediaPlayer
import Alamofire
import SwiftUI

class MusicPlayer: ObservableObject {
    var nowPlayingInfo: [String : Any] = [:]
    var player: AVPlayer?
    var isPlaying = false
    var currentTime: CMTime = .zero
    var timeObserverToken: Any?

    
    init() {
        print("🙏초기세팅")
        player?.automaticallyWaitsToMinimizeStalling = false
        player?.allowsExternalPlayback = false
        player?.play()
        
        setupRemoteCommands()
    }
    
    //    func playSound() {
    //        guard let url = Bundle.main.url(forResource: "music", withExtension: ".mp3") else { return }
    //            self.player = AVPlayer(url: url)
    //            player?.play()
    //            setupRemoteCommands()
    //            // 재생 중인 노래 정보를 설정
    //            var nowPlayingInfo: [String : Any] = [
    //                MPMediaItemPropertyTitle: "Your Song Title",
    //                MPMediaItemPropertyArtist: "Your Artist Name",
    //                MPMediaItemPropertyPlaybackDuration: player?.currentItem?.duration ?? 0,
    ////                MPMediaItemPropertyPlaybackDuration: player?.duration ?? 0,
    //                MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.currentItem?.duration ?? 0
    //            ]
    //            if let albumCoverPage = UIImage(named: "apple") {
    //                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
    //                    return albumCoverPage
    //                })
    //            }
    //            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    //    }
//    func readyToConnect(url: URL) async { // 음악 정보 가져오기
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        if url == Constants().currentmusic {
//            request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])
//        }
//        print(url.description)
//        let configuration = URLSessionConfiguration.default
//        // 0.8초
//        
//        do {
//            print("토큰 가져오는 시간 \(Date().timeIntervalSince1970)")
//            let token = try KeyChain.get()
//            print("토큰 가져온 시간 \(Date().timeIntervalSince1970)")
//            configuration.httpAdditionalHeaders = ["Authorization": token.token]
//        } catch {
//            print(error.localizedDescription)
//        }
//        let session = URLSession(configuration: configuration)
//        //URLSession(configuration: configuration)
//        print("웹으로부터 가져오기전 \(Date().timeIntervalSince1970)")
//        do {
//            let (data, _) = try await session.data(for: request)
//            print("웹으로부터 가져온 후 \(Date().timeIntervalSince1970)")
//            print("디코딩 전 \(Date().timeIntervalSince1970)")
//            let decoded = try JSONDecoder().decode(MusicInfoModel.self, from: data)
//            print("디코딩 후 \(Date().timeIntervalSince1970)")
//            print(decoded)
////            await setupMusicInfo(url: URL(string: decoded.filePath)!, info: decoded)
//        } catch {
//            
//        }
//    }
    
    
    func getMusicInfo(url: URL) async { // 음악 정보 가져오기
        print("함수 시작 시간 \(Date().timeIntervalSince1970)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if url == Constants().currentmusic {
            request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])
        }
        print(url.description)
        
        
        let configuration = URLSessionConfiguration.default
        // 0.8초
//        configuration.urlCache = URLCache.shared
//        configuration.requestCachePolicy = .returnCacheDataElseLoad
        do {
            print("토큰 가져오는 시간 \(Date().timeIntervalSince1970)")
            let token = try KeyChain.get()
            print("토큰 가져온 시간 \(Date().timeIntervalSince1970)")
            configuration.httpAdditionalHeaders = ["Authorization": token.token]
        } catch {
            print(error.localizedDescription)
        }

        
        do {
            print("토큰넣기 전 시간 \(Date().timeIntervalSince1970)")
            let session = URLSession(configuration: configuration)
            print("토큰넣은 이후 시간 \(Date().timeIntervalSince1970)")
            print("웹으로부터 가져오기전 \(Date().timeIntervalSince1970)")
            let (data, _) = try await session.data(for: request)
            print("웹으로부터 가져온 후 \(Date().timeIntervalSince1970)")
            print("디코딩 전 \(Date().timeIntervalSince1970)")
            let decoded = try JSONDecoder().decode(MusicInfoModel.self, from: data)
            print("디코딩 후 \(Date().timeIntervalSince1970)")
            print(decoded)
            await setupMusicInfo(url: URL(string: decoded.filePath)!, info: decoded)
        } catch {
            print(error)
        }
    }
    
//    func getMusicFromServer() async {
//
//        do {
//            let configuration = URLSessionConfiguration.default
//            configuration.urlCache = URLCache.shared
//            configuration.requestCachePolicy = .returnCacheDataElseLoad
//            print("토큰 가져오는 시간 \(Date().timeIntervalSince1970)")
//            let token = try KeyChain.get()
//            print("토큰 가져온 시간 \(Date().timeIntervalSince1970)")
//            configuration.httpAdditionalHeaders = ["Authorization": token.token]
//            var request = try URLRequest(url: Constants().currentmusic!, method: .get)
//            request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])
//            let session = URLSession(configuration: configuration)
//            print("웹으로부터 가져오기전 \(Date().timeIntervalSince1970)")
//            let (data, _) = try await session.data(for: request)
//            print("웹으로부터 가져온 후 \(Date().timeIntervalSince1970)")
//            print("디코딩 전 \(Date().timeIntervalSince1970)")
//            let decoded = try JSONDecoder().decode(MusicInfoModel.self, from: data)
//            print("디코딩 후 \(Date().timeIntervalSince1970)")
//            print(decoded)
//            await setupMusicInfo(url: URL(string: decoded.filePath)!, info: decoded)
//            configuration.urlCache = nil
//            configuration.requestCachePolicy = .useProtocolCachePolicy
//            print(token.token)
//        } catch {
//            
//        }
//    }
    
    func getMusicFromServer() async {
        do {
            let configuration = URLSessionConfiguration.default
            configuration.urlCache = URLCache.shared
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            let token = try KeyChain.get()
            configuration.httpAdditionalHeaders = ["Authorization": token.token]
            var request = try URLRequest(url: Constants().currentmusic!, method: .get)
            let session = URLSession(configuration: configuration)
            let (data, _) = try await session.data(for: request)
            let decoded = try JSONDecoder().decode(MusicInfoModel.self, from: data)
            await setupMusicInfo(url: URL(string: decoded.filePath)!, info: decoded)
            configuration.urlCache = nil
            configuration.requestCachePolicy = .useProtocolCachePolicy
            print(token.token)
        } catch {
            print(error)
        }
    }
    
    func getTest() {
        do {
            let parameters = ["heartRate": "80"]
            print("토큰 가져오기전 시간 \(Date().timeIntervalSince1970)")
            let token = try KeyChain.get()
            print("토큰 가져온 시간 \(Date().timeIntervalSince1970)")
            let url = Constants().currentmusic!
            print("웹으로부터 가져오기전 \(Date().timeIntervalSince1970)")
            AF.request(url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json", "Authorization": token.token])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MusicInfoModel.self) { response in
                print("웹으로부터 가져온 후 \(Date().timeIntervalSince1970)")
                Task {
                    await self.setupMusicInfo(url: URL(string: response.value?.filePath ?? "")!, info: response.value!)
                }
                print(response.value ?? "값이 없습니다요")
                print(token.token)
            }
        } catch {
            
        }
    }
    
    func getTest1() {

    }
    
    func handlePlaybackChange() {
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] =  CMTimeGetSeconds(player!.currentTime())
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    
    
    func setupMusicInfo(url: URL, info: MusicInfoModel) async { // 잠금화면에 띄우기
        print("음악 재생 전 \(Date().timeIntervalSince1970)")
        self.player = AVPlayer(url: url)
        print("음악 재생 직전 \(Date().timeIntervalSince1970)")
        player?.playImmediately(atRate: 1)
        print("음악 재생 후 \(Date().timeIntervalSince1970)")
        // 재생 중인 노래 정보를 설정
        do {
            let duration = try await player?.currentItem?.asset.load(.duration) // 현재 음악의 총 시간
            nowPlayingInfo = [
                MPMediaItemPropertyTitle: info.title,
                MPMediaItemPropertyArtist: info.artist,
                MPMediaItemPropertyPlaybackDuration: Int(duration!.seconds),
                MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(player!.currentTime()),
//                MPNowPlayingInfoPropertyPlaybackRate: player?.rate as Any
            ]
            
            var request = URLRequest(url: URL(string: info.albumUrl)!)
            request.httpMethod = "GET"
            
            let configuration = URLSessionConfiguration.default
            
            let session = URLSession(configuration: configuration)
            do {
                let (data, _) = try await session.data(for: request)
                if let albumCoverPage = UIImage(data: data) {
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                        return albumCoverPage
                    })
                }
            } catch {
                print(error)
            }
            
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            
        } catch {
            print(error)
        }
    }
    
    func stopSound() {
        player?.pause()
    }
    
    func setupRemoteCommands() {
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        remoteCommandCenter.previousTrackCommand.isEnabled = true
        remoteCommandCenter.nextTrackCommand.isEnabled = true
        remoteCommandCenter.skipBackwardCommand.isEnabled = true
        remoteCommandCenter.skipBackwardCommand.isEnabled = true
        remoteCommandCenter.changePlaybackPositionCommand.isEnabled = true
        remoteCommandCenter.playCommand.isEnabled = true
        remoteCommandCenter.pauseCommand.isEnabled = true
        
        NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: nil, queue: nil) { _ in
            Task {
                await self.getMusicInfo(url: Constants().nextmusic!)
            }
        }
        
        remoteCommandCenter.pauseCommand.addTarget { _ in
            self.pausePlayback()
            return .success
        }
        
        remoteCommandCenter.playCommand.addTarget { _ in
            self.resumePlayback()
            return .success
        }
        
        
        remoteCommandCenter.previousTrackCommand.addTarget { _ in
            Task {
                await self.previousPlayback()
            }
            return .success
        }
        
        remoteCommandCenter.nextTrackCommand.addTarget { _ in
            Task {
                await self.nextPlayback()
            }
            return .success
        }
        
        
        remoteCommandCenter.changePlaybackPositionCommand.addTarget { [weak self](remoteEvent) -> MPRemoteCommandHandlerStatus in
            guard let self = self else {return .commandFailed}
            if let player = self.player {
                let playerRate = player.rate
                if let event = remoteEvent as? MPChangePlaybackPositionCommandEvent {
                    player.seek(to: CMTime(seconds: event.positionTime, preferredTimescale: CMTimeScale(1000)), completionHandler: { [weak self](success) in
                        guard let self = self else {return}
                        if success {
                            self.player?.rate = playerRate
                        }
                    })
                    return .success
                }
            }
            return .commandFailed
        }
    }
    
    
    
    private func seek(to time: CMTime) {
        player!.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) {
            isFinished in
            if isFinished {
                self.handlePlaybackChange()
            }
        }
    }
    
    func togglePlayback() {
        if isPlaying {
            pausePlayback()
        } else {
            resumePlayback()
        }
    }
    
    func pausePlayback() {
        isPlaying = false
        player?.pause()
        handlePlaybackChange()
    }
    
    func resumePlayback() {
        isPlaying = true
        player?.play()
        handlePlaybackChange()
    }
    
    func previousPlayback() async {
        isPlaying = true
        print("이전버튼")
        await getMusicInfo(url: Constants().previousmusic!)
    }
    
    func nextPlayback() async {
        isPlaying = true
        print("다음버튼")
        await getMusicInfo(url: Constants().nextmusic!)
    }
    
}


class NetworkManager {
    static let shared = NetworkManager()
    private var isNetworkInitialized = false
    
    private init() {}
    
    func initializeNetwork() {
        guard !isNetworkInitialized else { return }
        
        // 네트워크 초기화 작업 수행
        // 예: URLSession 초기화
        
        isNetworkInitialized = true
    }
    
    func fetchDataFromServer(completion: @escaping (Result<Data, Error>) -> Void) async {
        initializeNetwork() // 네트워크 초기화
        
        // 서버에서 데이터 가져오기
        // 예: URLSession 사용
//        do {
//            let configuration = URLSessionConfiguration.default
//            configuration.urlCache = URLCache.shared
//            configuration.requestCachePolicy = .returnCacheDataElseLoad
//            print("토큰 가져오는 시간 \(Date().timeIntervalSince1970)")
//            let token = try KeyChain.get()
//            print("토큰 가져온 시간 \(Date().timeIntervalSince1970)")
//            configuration.httpAdditionalHeaders = ["Authorization": token.token]
//            var request = try URLRequest(url: Constants().currentmusic!, method: .get)
//            request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])
//            let session = URLSession(configuration: configuration)
//            print("웹으로부터 가져오기전 \(Date().timeIntervalSince1970)")
//            let (data, _) = try await session.data(for: request)
//            print("웹으로부터 가져온 후 \(Date().timeIntervalSince1970)")
//            print("디코딩 전 \(Date().timeIntervalSince1970)")
//            let decoded = try JSONDecoder().decode(MusicInfoModel.self, from: data)
//            print("디코딩 후 \(Date().timeIntervalSince1970)")
//            print(decoded)
//            await setupMusicInfo(url: URL(string: decoded.filePath)!, info: decoded)
//            configuration.urlCache = nil
//            configuration.requestCachePolicy = .useProtocolCachePolicy
//            print(token.token)
//        } catch {
//            
//        }
        // 데이터를 가져온 후 처리
        // 예: completion 핸들러 호출
    }
}
