//
//  MusicPlayer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/2/24.
//

import AVFoundation
import MediaPlayer
import SwiftAudioPlayer
import SwiftUI

class MusicPlayer: ObservableObject {
    //    static let instance = MusicPlayer()
    //    var player: AVAudioPlayer?
    var session: MPNowPlayingSession?
    var nowPlayingInfo: [String : Any] = [:]
    var player: AVPlayer?
    var isPlaying = false
    var forwardpressed = false
    var backwardpressed = false
    var nextpressed = false
    var previouspressed = false
    var currentTime: CMTime = .zero
    init() {
        print("🙏초기세팅")
        setupRemoteCommands()
        //        self.session = MPNowPlayingSession(players: [player!])
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
    
    //    init() {
    //            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    //        }
    
    //    @objc private func playerItemDidReachEnd(_ notification: Notification) async {
    //            print("노래 끝나는데")
    ////        await getMusicInfo(url: Constants().nextmusic!)
    //        }
    
    func getMusicInfo(url: URL) async { // 음악 정보 가져오기
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if url == Constants().currentmusic {
            request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])
        }
        print(url.description)
        
        let configuration = URLSessionConfiguration.default
        do {
            let token = try KeyChain.get()
            configuration.httpAdditionalHeaders = ["Authorization": token.token]
        } catch {
            print(error.localizedDescription)
        }
        
        
        let session = URLSession(configuration: configuration)
        do {
            let (data, _) = try await session.data(for: request)
            let musicinfo = try JSONDecoder().decode(MusicInfoModel.self, from: data)
            print(musicinfo)
            //            await getMusic(url: URL(string: musicinfo.filePath)!)
            await setupMusicInfo(url: URL(string: musicinfo.filePath)!, info: musicinfo)
        } catch {
            print(error)
        }
    }
    
    func handlePlaybackChange() {
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] =  CMTimeGetSeconds(player!.currentTime())
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func addBoundaryTimeObserver() {
        var times = [NSValue]()
        // Set initial time to zero
        var currentTime = CMTime.zero
        // Divide the asset's duration into quarters.
        let interval = CMTimeMultiplyByFloat64((player?.currentItem!.duration)!, multiplier: 0.25)
        
        // Build boundary times at 25%, 50%, 75%, 100%
        while currentTime < (player?.currentItem!.duration)! {
            currentTime = currentTime + interval
            times.append(NSValue(time: currentTime))
        }
        
        // Add time observer. Observe boundary time changes on the main queue.
        player!.addBoundaryTimeObserver(forTimes: times, queue: .main) {
            // Update UI
            print("25%완료")
            Task {
                await self.getMusicInfo(url: Constants().nextmusic!)
            }
        }
    }
    
    
    
    func setupMusicInfo(url: URL, info: MusicInfoModel) async { // 잠금화면에 띄우기
        self.player = AVPlayer(url: url)
        player?.play()
        print("노래 시작을 알린다")
        NotificationCenter.default.addObserver(forName: AVPlayerItem.didPlayToEndTimeNotification, object: nil, queue: nil) { Notification in
            print("노래가 끝났습니다.")
            //            Task {
            //                await self.getMusicInfo(url: Constants().nextmusic!)
            //            }
        }
        
        // 재생 중인 노래 정보를 설정
        do {
            let duration = try await player?.currentItem?.asset.load(.duration) // 현재 음악의 총 시간
            nowPlayingInfo = [
                MPMediaItemPropertyTitle: info.title,
                MPMediaItemPropertyArtist: info.artist,
                MPMediaItemPropertyPlaybackDuration: Int(duration!.seconds),
                MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(player!.currentTime()),
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
        remoteCommandCenter.seekForwardCommand.isEnabled = true
        remoteCommandCenter.seekBackwardCommand.isEnabled = true
        remoteCommandCenter.changePlaybackPositionCommand.isEnabled = true
        remoteCommandCenter.playCommand.isEnabled = true
        remoteCommandCenter.pauseCommand.isEnabled = true
        
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
                self.nextpressed = true
            }
            //            }
            return .success
        }
        
        //        remoteCommandCenter.seekBackwardCommand.addTarget { event in
        ////            let currentTime = CMTimeGetSeconds(self.player!.currentTime())
        ////            let targetTime = currentTime - 10 // 현재 시간에서 10초 뒤로 설정
        //            let currentTime = self.player!.currentTime()
        //            let targetTime = CMTimeSubtract(currentTime, CMTime(seconds: 10, preferredTimescale: 1)) // 현재 시간에서 10초를 빼는 값
        //
        //            if !self.backwardpressed {
        //                self.seek(to: targetTime)
        //                self.backwardpressed = true
        //            } else {
        //                self.backwardpressed = false
        //            }
        //            return .success
        //        }
        remoteCommandCenter.seekBackwardCommand.addTarget { [self] event in
            print("앞으로 감기")
            remoteCommandCenter.stopCommand.isEnabled = true
            currentTime = CMTimeSubtract(self.currentTime, CMTime(seconds: 10, preferredTimescale: 1))
            if !self.backwardpressed && self.forwardpressed {
                self.seek(to: currentTime)
                self.backwardpressed = true
            } else {
                self.backwardpressed = false
            }
            remoteCommandCenter.stopCommand.isEnabled = false
            return .success
            //            guard let player = self.player else { return .commandFailed }
            //
            //            // 현재 시간에서 10초를 빼는 값을 계산하여 currentTime을 업데이트합니다.
            //            self.currentTime = CMTimeSubtract(self.currentTime, CMTime(seconds: 10, preferredTimescale: 1))
            //
            //            // currentTime으로 이동합니다.
            //            player.seek(to: self.currentTime) { success in
            //                if success {
            //                    print("미디어를 10초 뒤로 이동했습니다.")
            //                } else {
            //                    print("미디어 이동에 실패했습니다.")
            //                }
            //            }
            //
            //            return .success
        }
        
        remoteCommandCenter.seekForwardCommand.addTarget { [self] event in
            print("뒤로 감기")
            currentTime = CMTimeAdd(self.currentTime, CMTime(seconds: 10, preferredTimescale: 1))
            //            let currentTime = CMTimeGetSeconds(self.player!.currentTime())
            //            let targetTime = currentTime + 10 // 현재 시간에서 10초 뒤로 설정
            if !self.forwardpressed {
                self.seek(to: currentTime)//to: CMTime(seconds: targetTime, preferredTimescale: 1))
                self.forwardpressed = true
            } else {
                self.forwardpressed = false
            }
            return .success
        }
        //        remoteCommandCenter.seekForwardCommand.addTarget { event in
        //            guard let player = self.player else {
        //                return .commandFailed
        //            }
        //
        //            let currentTime = CMTimeGetSeconds(player.currentTime())
        //            let targetTime = currentTime + 10 // 현재 시간에서 10초 뒤로 설정
        //
        //            let duration = CMTimeGetSeconds(player.currentItem?.duration ?? .zero)
        //            if targetTime >= duration { // 목표 시간이 미디어의 총 재생 시간보다 클 경우
        //                // 여기에 처리할 로직 추가
        //                return .commandFailed // 명령이 실패했음을 알림
        //            }
        //
        //            player.seek(to: CMTime(seconds: targetTime, preferredTimescale: 1)) { success in
        //                if success {
        //                    print("10초 뒤로 빨리감기 성공")
        //                    // 여기에 처리할 로직 추가
        //                    return  // 명령이 성공했음을 알림
        //                } else {
        //                    print("10초 뒤로 빨리감기 실패")
        //                    // 여기에 처리할 로직 추가
        //                    return //.commandFailed // 명령이 실패했음을 알림
        //                }
        //            }
        //            return .success
        //        }
        
        //
        //        remoteCommandCenter.changePlaybackPositionCommand.addTarget(handler: { (event) in
        //            // Handle position change
        ////            self.seek(to: event. - self.player?.currentTime()!)
        //            return MPRemoteCommandHandlerStatus.success
        //        })
        
    }
    
    
    
    private func seek(to time: CMTime) {
        player!.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero) {
            isFinished in
            if isFinished {
                print("검색중")
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
        // Pause playback logic
        isPlaying = false
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyPlaybackRate] = 0
        player?.pause()
    }
    
    func resumePlayback() {
        // Resume playback logic
        isPlaying = true
        MPNowPlayingInfoCenter.default().nowPlayingInfo?[MPNowPlayingInfoPropertyPlaybackRate] = 1
        player?.play()
    }
    
    func previousPlayback() async {
        isPlaying = true
        //        playSound()
        print("이전버튼")
        await getMusicInfo(url: Constants().previousmusic!)
    }
    
    func nextPlayback() async {
        isPlaying = true
        //        nextSound()
        print("다음버튼")
        await getMusicInfo(url: Constants().nextmusic!)
    }
    
}
