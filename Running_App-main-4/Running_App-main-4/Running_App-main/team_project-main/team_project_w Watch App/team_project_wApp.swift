//
//  team_project_wApp.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI

@main
struct team_project_w_Watch_AppApp: App {
    @StateObject private var connectManager = WatchToiOS()
    @StateObject private var workoutManager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self])
                .environmentObject(connectManager)
                .environmentObject(workoutManager)
//            SessionPagingView()
//            SelectingView()
//                .environmentObject(connectManager)
//                .environmentObject(workoutManager)
        }

    }
}
