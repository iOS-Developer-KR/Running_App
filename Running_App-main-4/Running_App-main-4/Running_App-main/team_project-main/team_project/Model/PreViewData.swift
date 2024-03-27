//
//  PreViewData.swift
//  team_project
//
//  Created by Taewon Yoon on 3/21/24.
//

import Foundation
import SwiftUI


struct PreviewData {
    var previewExerciseRoutineContainer: ExerciseRoutineContainer = .init(id: nil, routineName: "루틴1", exerciseDefaultModel: [.init(exerciseName: "백", part: [.abs], tool: .barbell)])

}

@Observable
class NavigationObject {
    var path: NavigationPath
    
    init(path: NavigationPath) {
        self.path = path
    }
}
