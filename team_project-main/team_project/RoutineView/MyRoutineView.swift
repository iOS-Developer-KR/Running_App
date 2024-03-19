//
//  MyRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI
import SwiftData

struct MyRoutineView: View {
    
    @Query var exerciseData: [Exercise]
    
    var body: some View {
            ForEach(exerciseData) { exercise in // 루틴
                HStack {
                    NavigationLink {
                        RoutineListView(exercise: exercise)
                    } label: {
                        Text(exercise.routineName)
                    }
                    
                    
                }
            }
            .onChange(of: exerciseData) { oldValue, newValue in
                print("값이 변했다:\(oldValue.count) -> \(newValue.count)")
            }
            .onAppear {
                print(exerciseData.count)
            }
        }
    
}

#Preview {
    MyRoutineView()
}
