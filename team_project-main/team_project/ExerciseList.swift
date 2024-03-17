//
//  ExerciseList.swift
//  team_project
//
//  Created by Taewon Yoon on 10/29/23.
//

import SwiftUI

struct ExerciseListView: View {
    @Binding var targetPart: ExercisePart?
    @Binding var targetTool: ExerciseTool?

    var body: some View {
        List {
            ForEach(filteredExercises, id: \.self) { exercise in
                Text(exercise.exerciseName)
            }
        }
        .navigationTitle("Exercises")
        .onChange(of: targetPart) { oldValue, newValue in
//            print("변했다:\(targetPart), \(targetTool)")
        }
    }

    var filteredExercises: [ExerciseDataModel] {
        switch targetPart {
        case .wholeBody:
            if targetTool == .wholeBody { // 모든 도구
                return ExerciseData.allExercies
            } else { // 특정 도구
                return ExerciseData.allExercies.filter { exercise in
                    return exercise.tool == targetTool
                }
            }
            
        case .chest:
            if targetTool == .wholeBody {
                return ExerciseData.chestExercises
            } else { // 특정 도구
                return ExerciseData.chestExercises.filter { exercise in
                    return exercise.part.first == targetPart && exercise.tool == targetTool
                }
            }
        case .back: break
            
        case .shoulders: break
            
        case .triceps: break
            
        case .biceps: break
            
        case .forearms: break
            
        case .abs: break
            
        case .glutes: break
        
        case .hamstrings: break
            
        case .quadriceps: break
            
        case .trapezius: break
            
        case .calves: break
            
        case nil: break
            
        }
        return ExerciseData.chestExercises.filter { exercise in
            return exercise.part.first == targetPart && exercise.tool == targetTool
        }
    }
}

#Preview {
    ExerciseListView(targetPart: .constant(.hamstrings), targetTool: .constant(.machine))
}
