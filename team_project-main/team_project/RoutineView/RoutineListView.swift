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
    @State private var pressed = false
    
    var body: some View {
        VStack {
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
                    AddingRoutineView(exercise: exercise)
                } label: {
                    Text("운동 추가")
                        .bold()
                        .foregroundStyle(.white)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.red)
                .foregroundStyle(Color.white)

//                Button(action: {
//                    pressed.toggle()
//                }, label: {
//                    Text("운동 추가")
//                        .bold()
//                        .foregroundStyle(.white)
//                })
//                .buttonStyle(BorderedProminentButtonStyle())
//                .tint(.red)
//                .foregroundStyle(Color.white)
            }
            
            
        }
        .onAppear(perform: {
            print(exercise.routines.count)
        })
//        .sheet(isPresented: $pressed, content: {
//            AddingRoutineView(exercise: exercise)
//        })
    }
}

#Preview {
    RoutineListView(exercise: .init())
        .modelContainer(PreviewContainer.container)
}
