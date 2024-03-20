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
        List(exercise.routines) { ex in
            NavigationLink {
                RoutineRecordView(exercise: ex)
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(ex.exerciseName)
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.orange)
                        
                        HStack {
                            ForEach(ex.part) { part in
                                Text(part.rawValue)
                                    .font(.footnote)
                                    .multilineTextAlignment(.leading)

                            }
                        }
                        
                    }
                    Spacer()
                    
//                    Image(systemName: ex.checked ? "checkmark.circle.fill" : "circle")
//                        .foregroundStyle(ex.checked ? .green : .gray)
                }
            }


//            .onTapGesture {
//                // 운동 리스트뷰로 넘어가기
//
//                self.selected = ex
//                if let index = exercise.routines.firstIndex(where: { $0.id == selected?.id }) {
//                    exercise.routines[index].checked.toggle()
//                }
//            }
        

        }
    }
}

#Preview {
    RoutineListView(exercise: .init()).modelContainer(PreviewContainer.container)
}
