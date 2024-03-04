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
    
    func getMusicInfo() async { // 음악 정보 가져오기
        var request = URLRequest(url: URL(string: "http://lsproject.shop:8080/audio")!)
        request.httpMethod = "GET"
        request.url?.append(queryItems: [URLQueryItem(name: "heartRate", value: "80")])

        let configuration = URLSessionConfiguration.default
                
        let session = URLSession(configuration: configuration)
        print(request.url!)
        do {
            let (data, _) = try await session.data(for: request)
            let musicinfo = try JSONDecoder().decode(MusicInfoModel.self, from: data)
            print(musicinfo)
            await setupMusicInfo(info: musicinfo)
            await getMusic(url: URL(string: musicinfo.filePath)!)
        } catch {
            print(error)
        }
    }
    
    func getMusic(url: URL) async { // 음악 가져와서 재생하기
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = ["Accept": "audio/mpeg"]
        
        let session = URLSession(configuration: configuration)
        print(request.url!)
        do {
            let (data, _) = try await session.data(for: request)
            print(data)
            self.player = try AVAudioPlayer(data: data)
            player?.play()
            setupRemoteCommands()
        } catch {
            print(error)
        }
    }
    
    func setupMusicInfo(info: MusicInfoModel) async { // 잠금화면에 띄우기
        // 재생 중인 노래 정보를 설정
        var nowPlayingInfo: [String : Any] = [
            MPMediaItemPropertyTitle: info.title,
            MPMediaItemPropertyArtist: info.artist,
            MPMediaItemPropertyPlaybackDuration: player?.duration ?? 0,
            MPNowPlayingInfoPropertyElapsedPlaybackTime: player?.currentTime ?? 0
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
