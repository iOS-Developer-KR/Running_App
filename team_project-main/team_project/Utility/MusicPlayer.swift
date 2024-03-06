//
//  MusicPlayer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/2/24.
//

import AVFoundation
import MediaPlayer
import SwiftAudioPlayer

class MusicPlayer: ObservableObject {
    static let instance = MusicPlayer()
    //    var player: AVAudioPlayer?
    var player: AVPlayer?
    var isPlaying = false
    
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
    
    func getMusicInfo(url: URL) async { // 음악 정보 가져오기
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if url == Constants().currentmusic {
            request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])
        }
        
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
            
            setupRemoteCommands()
            //            await getMusic(url: URL(string: musicinfo.filePath)!)
            await setupMusicInfo(url: URL(string: musicinfo.filePath)!, info: musicinfo)
        } catch {
            print(error)
        }
    }
    
    //    func getMusic(url: URL) async { // 음악 가져와서 재생하기
    //
    //        do {
    //            let duration = try await player?.currentItem?.asset.load(.duration)
    //            print("여기좀 확인해봐" + (duration?.seconds.description)!)
    //            var nowPlayingInfo: [String : Any] = [
    //                MPNowPlayingInfoPropertyElapsedPlaybackTime: Int(duration!.seconds),
    //            ]
    //            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    //
    //
    //        } catch {
    //
    //        }
    //        print(player?.currentItem?.duration.seconds.description)
    //        print(CMTimeGetSeconds((player?.currentItem?.asset.duration)!))
    //    }
    
    func setupMusicInfo(url: URL, info: MusicInfoModel) async { // 잠금화면에 띄우기
        self.player = AVPlayer(url: url)
        player?.play()
        // 재생 중인 노래 정보를 설정
        do {
            let duration = try await player?.currentItem?.asset.load(.duration)
            print("여기좀 확인해봐" + (duration?.seconds.description)!)//
//            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = 30 = duration?.seconds

        var nowPlayingInfo: [String : Any] = [
            MPMediaItemPropertyTitle: info.title,
            MPMediaItemPropertyArtist: info.artist,
            MPMediaItemPropertyPlaybackDuration: Int(duration!.seconds),//Int((player?.currentTime().seconds)!),
            MPNowPlayingInfoPropertyElapsedPlaybackTime: CMTimeGetSeconds(player!.currentTime()),
            MPNowPlayingInfoPropertyPlaybackRate: player?.rate
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
        remoteCommandCenter.skipBackwardCommand.isEnabled = false
        remoteCommandCenter.skipForwardCommand.isEnabled = false
        remoteCommandCenter.playCommand.isEnabled = true
        remoteCommandCenter.pauseCommand.isEnabled = true
        remoteCommandCenter.previousTrackCommand.isEnabled = true
        remoteCommandCenter.nextTrackCommand.isEnabled = true
        remoteCommandCenter.stopCommand.isEnabled = true
        
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
        
        //        remoteCommandCenter.
        
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
        print(player?.currentTime().seconds.description)
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
