//
//  MusicPlayer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/2/24.
//

import AVFoundation
import MediaPlayer

class MusicPlayer {
    static let instance = MusicPlayer()
    var player: AVAudioPlayer?
    var isPlaying = false
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            setupRemoteCommands()
            // 재생 중인 노래 정보를 설정
            var nowPlayingInfo: [String : Any] = [
                MPMediaItemPropertyTitle: "Your Song Title",
                MPMediaItemPropertyArtist: "Your Artist Name",
                MPMediaItemPropertyPlaybackDuration: player?.duration ?? 0,
                MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.currentTime ?? 0
            ]
            if let albumCoverPage = UIImage(named: "apple") {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                    return albumCoverPage
                })
            }
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getMusic() async {
        var request = URLRequest(url: URL(string: "http://lsproject.shop:8080/audio")!)
        request.httpMethod = "GET"
        request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])

        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = ["Accept": "audio/mpeg"]
        
        let session = URLSession(configuration: configuration)
        print(request.url!)
        do {
            let (data, response) = try await session.data(for: request)
            print(data)
            print(response.description)
            self.player = try AVAudioPlayer(data: data)
            player?.play()
            setupRemoteCommands()
            setupMusicInfo()
        } catch {
            print(error)
        }
    }
    
    func setupMusicInfo() {
        // 재생 중인 노래 정보를 설정
        var nowPlayingInfo: [String : Any] = [
            MPMediaItemPropertyTitle: "Your Song Title",
            MPMediaItemPropertyArtist: "Your Artist Name",
            MPMediaItemPropertyPlaybackDuration: player?.duration ?? 0,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.currentTime ?? 0
        ]
        if let albumCoverPage = UIImage(named: "apple") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                return albumCoverPage
            })
        }
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    func nextSound() {
        guard let url = Bundle.main.url(forResource: "music2", withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            setupRemoteCommands()
            // 재생 중인 노래 정보를 설정
            var nowPlayingInfo: [String : Any] = [
                MPMediaItemPropertyTitle: "Your Song Title",
                MPMediaItemPropertyArtist: "Your Artist Name",
                MPMediaItemPropertyPlaybackDuration: player?.duration ?? 0,
                MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.currentTime ?? 0
            ]
            if let albumCoverPage = UIImage(named: "gym") {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in
                    return albumCoverPage
                })
            }
            MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopSound() {
        player?.stop()
    }
    
    func setupRemoteCommands() {
        let remoteCommandCenter = MPRemoteCommandCenter.shared()
        
        remoteCommandCenter.pauseCommand.addTarget { _ in
            self.pausePlayback()
            return .success
        }
        
        remoteCommandCenter.playCommand.addTarget { _ in
            self.resumePlayback()
            return .success
        }
        
        remoteCommandCenter.previousTrackCommand.addTarget { _ in
            self.previousPlayback()
            return .success
        }
        
        remoteCommandCenter.nextTrackCommand.addTarget { _ in
            self.nextPlayback()
            return .success
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
        player?.pause()
    }
    
    func resumePlayback() {
        // Resume playback logic
        isPlaying = true
        player?.play()
    }
    
    func previousPlayback() {
        isPlaying = true
        playSound()
    }
    
    func nextPlayback() {
        isPlaying = true
        nextSound()
    }
    
}
