//
//  PreviewContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import Foundation
import SwiftData

class PreviewContainer {
    @MainActor
    static let container: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: ExerciseRoutineContainer.self,configurations: config)//, ExerciseRecord.self, configurations: config)
            let exerciseContainer = ExerciseRoutineContainer(exerciseDataModel: [.init(exerciseName: "랫풀다운", part: [.back], tool: .machine)], routineName: "등조지는날")
            //ExerciseRoutineContainer(exerciseDataModel: [.init(exerciseName: "랫풀다운", part: [.back], tool: .machine)], routineName: "등조지는날")
            let recordContainer = PreviewData().previewExerciseRoutineContainer
//            let exerciseRecord = ExerciseRecord(recordDate: Date(), totalTime: 33)

            let exerciseDataModel = ExerciseDataModel(exerciseName: "하체하체", part: [.hamstrings], tool: .machine)
            container.mainContext.insert(exerciseContainer)
            container.mainContext.insert(recordContainer)
            container.mainContext.insert(exerciseDataModel)
//            container.mainContext.insert(exerciseModel)
            
            return container
        } catch {
            fatalError("Failed to create container")
        }
    }()
    @MainActor
    static var sample: ExerciseRoutineContainer {
        let context = PreviewContainer.container.mainContext
        let descriptor = FetchDescriptor<ExerciseRoutineContainer>(predicate: #Predicate { _ in true }, sortBy: [SortDescriptor(\.routineName)])
        do {
            let results = try context.fetch(descriptor)
            return results[0]
        } catch {
            fatalError("Failed to get sample")
        }
    }
}
