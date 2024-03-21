//
//  TimeManager.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI

class TimerManager: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var elapsedTime2: String = ""
    @Published var checking: Bool = false
    @Published var exerciseRoutineContainer: ExerciseRoutineContainer?
    var timer: Timer?
    var startTime: Date?
    var routineName: String = ""
    
    func start() {
        checking = true
        startTime = Date()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let strongSelf = self, let startTime = strongSelf.startTime else { return }
            let currentTime = Date().timeIntervalSince(startTime)
            strongSelf.elapsedTime = currentTime
            strongSelf.elapsedTime2 = strongSelf.formatTimeInterval(currentTime)
        }
    }
    
    func stop() {
        checking = false
        timer?.invalidate()
        timer = nil
    }
    
    private func formatTimeInterval(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        let seconds = Int(seconds) % 60
        
        var timeString = ""
        if hours > 0 {
            timeString += "\(hours)시간 "
        }
        if minutes > 0 || hours > 0 {
            timeString += "\(minutes)분 "
        }
        timeString += "\(seconds)초"
        
        return timeString
    }
}

extension TimerManager {
    func convertSecondsToReadableTime(_ seconds: Int) -> String {
            let hours = seconds / 3600
            let minutes = (seconds % 3600) / 60
            let remainingSeconds = seconds % 60
            
            // 시간, 분, 초를 문자열로 조합
            var timeString = ""
            
            if hours > 0 {
                timeString += "\(hours)시간 "
            }
            
            if minutes > 0 || hours > 0 { // 시간이 있으면 분도 표시, 시간이 없더라도 분이 있으면 표시
                timeString += "\(minutes)분 "
            }
            
            if remainingSeconds > 0 || (hours == 0 && minutes == 0) { // 시간과 분이 모두 0이면 초만 표시
                timeString += "\(remainingSeconds)초"
            }
            
            return timeString.trimmingCharacters(in: .whitespaces)
        }
}
