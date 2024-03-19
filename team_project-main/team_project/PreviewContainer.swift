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
         let container = try ModelContainer(for: Exercise.self, configurations: config)
         let ex = Exercise(routineName: "1", routines: [ExerciseDataModel(exerciseName: "데드", part: [.abs], tool: .barbell)])
         container.mainContext.insert(ex)

         return container
      } catch {
         fatalError("Failed to create container")
      }
   }()
   @MainActor
   static var sample: Exercise {
      let context = PreviewContainer.container.mainContext
       let descriptor = FetchDescriptor<Exercise>(predicate: #Predicate { _ in true }, sortBy: [SortDescriptor(\.routineName)])
      do {
         let results = try context.fetch(descriptor)
         return results[0]
      } catch {
         fatalError("Failed to get sample")
      }
   }
}
