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
//    var selected: ExerciseRoutineContainer
    @Environment(\.modelContext) var dbContext
    @EnvironmentObject var timeManager: TimerManager
    @State private var pressed = false
    
    
    func saveRecord() {
        
    }
    
    func startExercise() {
        timeManager.exerciseRoutineContainer = self.exerciseContainer
        timeManager.start()
    }
    
    func stopExercise() {
        timeManager.stop()
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
                    // 운동 시작
                    timeManager.checking.toggle()
//                    timeManager
                }, label: {
                    Text(timeManager.checking ? "운동 종료" : "운동 시작")
                        .bold()
                        .foregroundStyle(.white)
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(timeManager.checking ? .green : .red)
                .foregroundStyle(Color.white)
                
                
                NavigationLink {
                    AddingRoutineView(exercise: exerciseContainer)
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
        .onChange(of: timeManager.checking) { oldValue, newValue in
            if newValue {
                self.startExercise()
            } else {
                self.stopExercise()
            }
        }

//        var record = selected?.exerciseData?.record.contains(where: { record in
//            record.exerciseData?.routines.contains(where: { exercise in
//                exercise.exerciseName ==
//            })
//        })
    }
}

//#Preview {
//    RoutineListView(exerciseContainer: PreviewData().previewExerciseRoutineContainer, selected: PreviewData().previewExerciseRoutineContainer)
//        .environmentObject(TimerManager())
//    
////        .modelContainer(PreviewContainer.container)
//}
