//
//  ExerciseList.swift
//  team_project
//
//  Created by Taewon Yoon on 10/29/23.
//

import SwiftUI

struct ExerciseListView: View {
    @Binding var targetPart: ExercisePart
    @Binding var targetTool: ExerciseTool

    var body: some View {
        List {
            ForEach(filteredExercises, id: \.self) { exercise in
                Text(exercise.exerciseName)
            }
        }
        .navigationTitle("Exercises")
        .onChange(of: targetPart) { oldValue, newValue in
            print("변했다:\(targetPart), \(targetTool)")
        }
    }

    var filteredExercises: [ExerciseDataModel] {
        return ExerciseData.allExercises.filter { exercise in
            return exercise.part.first == targetPart && exercise.tool == targetTool
        }
    }
}

#Preview {
    ExerciseListView(targetPart: .constant(.hamstrings), targetTool: .constant(.machine))
}
