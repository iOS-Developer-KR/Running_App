//
//  RoutineListCell.swift
//  team_project
//
//  Created by Taewon Yoon on 3/19/24.
//

import SwiftUI
import SwiftData

struct RoutineListView: View {
    
    var exerciseContainer: ExerciseRoutineContainer
    var selected: ExerciseRoutineContainer
    @Environment(\.modelContext) var dbContext
    @State private var pressed = false
    
//    func get() {
//        var record = selected?.exerciseData?.record
//    }
    
    func saveRecord() {
        
    }
    
    var body: some View {
        VStack {
            List(exerciseContainer.exercise) { selected in
                NavigationLink {
                    // selected는 운동루틴에 한 종류를 의미한다
                    RoutineRecordView(selectedExercise: selected)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(selected.exerciseName)")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.orange)
                            
                            HStack {
                                ForEach(selected.part) { part in
                                    Text(part.rawValue)
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                        }
                        Spacer()
                        
                    }
                }
            }
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("운동 시작")
                        .bold()
                        .foregroundStyle(.white)
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.red)
                .foregroundStyle(Color.white)
                
                
                NavigationLink {
                    AddingRoutineView(exercise: selected)
                } label: {
                    Text("운동 추가")
                        .bold()
                        .foregroundStyle(.white)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.red)
                .foregroundStyle(Color.white)


            }
            
            
        }
        .onAppear(perform: {
//            print(exercise.routines.count)
        })

//        var record = selected?.exerciseData?.record.contains(where: { record in
//            record.exerciseData?.routines.contains(where: { exercise in
//                exercise.exerciseName ==
//            })
//        })
    }
}

#Preview {
    RoutineListView(exerciseContainer: PreviewData().previewExerciseRoutineContainer, selected: PreviewData().previewExerciseRoutineContainer)
//        .modelContainer(PreviewContainer.container)
}
