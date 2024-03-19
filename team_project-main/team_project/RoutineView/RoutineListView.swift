//
//  RoutineListCell.swift
//  team_project
//
//  Created by Taewon Yoon on 3/19/24.
//

import SwiftUI
import SwiftData

struct RoutineListView: View {
    
    var exercise: Exercise
    @State private var selected: ExerciseDataModel?
    @Environment(\.modelContext) var dbContext
    
    var body: some View {
        VStack {
            ForEach(exercise.routines) { ex in
                HStack {
                    VStack {
                        HStack {
                            Text(ex.exerciseName)
                            Spacer()
                        }
                        HStack {
                            ForEach(ex.part) { part in
                                Text(part.rawValue)
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    Image(systemName: ex.checked ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(ex.checked ? .green : .gray)
                }
                .onTapGesture {
                    self.selected = ex
                    if let index = exercise.routines.firstIndex(where: { $0.id == selected?.id }) {
                        exercise.routines[index].checked.toggle()
                    }
                    
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    RoutineListView(exercise: .init())
}
