//
//  Health_AppApp.swift
//  Health_App Watch App
//
//  Created by Taewon Yoon on 3/14/24.
//

import SwiftUI

@main
struct Health_App_Watch_AppApp: App {
    @StateObject var manager = WorkoutManager()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            test()
//            test2()
        }
    }
}
