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
            let exerciseContainer = ExerciseRoutineContainer(routineName: "루틴1", exerciseDefaultModel: [.init(exerciseName: "루틴임", part: [.abs], tool: .barbell)])
            let recordContainer = PreviewData().previewExerciseRoutineContainer
//            let exerciseRecord = ExerciseRecord(recordDate: Date(), totalTime: 33)
//            let exercise = Exercise()
            let exerciseModel = ExerciseDefaultModel(exerciseName: "하체하체", part: [.hamstrings], tool: .machine)
//            let re = ExerciseRecord(exercise: <#Exercise#>, routineName: "하체같은 등", date: Date(), exerciseData: ex.routines.first)
            container.mainContext.insert(exerciseContainer)
            container.mainContext.insert(recordContainer)
//            container.mainContext.insert(exerciseRecord)
//            container.mainContext.insert(exercise)
            container.mainContext.insert(exerciseModel)
            
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
