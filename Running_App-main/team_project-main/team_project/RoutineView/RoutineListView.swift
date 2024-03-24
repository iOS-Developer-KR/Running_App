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
    @State private var paused = false
    
    
    func saveRecord() {
        
    }
    
//    func startExercise() {
//        timeManager.exerciseRoutineContainer = self.exerciseContainer
//        timeManager.start()
//    }
//    
//    func stopExercise() {
//        timeManager.stop()
//    }
    
    var body: some View {
        VStack {
            List(exerciseContainer.exerciseDefaultModel) { selected in
                NavigationLink {
                    // selected는 운동루틴에 한 종류를 의미한다
                    RoutineRecordView(selectedExercise: selected, set: selected.set, count: selected.count, kg: selected.kg, done: selected.done)
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
                    // 운동 시작 // 타이머가 꺼져있으면 타이머 시작 // 타이머가 켜져있으면 중단
                    if timeManager.timerOn && !timeManager.stopped {
                        timeManager.stop()
                    } else {
                        timeManager.exerciseRoutineContainer = exerciseContainer
                        timeManager.start()
                    }
//                    timeManager
                }, label: { // 타이머가 작동중이면서 중지되지 않았다면
                    Text(timeManager.timerOn && !timeManager.stopped ? "운동 종료" : "운동 시작")
                        .bold()
                        .foregroundStyle(.white)
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(timeManager.timerOn ? .green : .red)
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


    }
}

//#Preview {
//    RoutineListView(exerciseContainer: PreviewData().previewExerciseRoutineContainer, selected: PreviewData().previewExerciseRoutineContainer)
//        .environmentObject(TimerManager())
//    
////        .modelContainer(PreviewContainer.container)
//}
