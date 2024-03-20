//
//  RoutineRecordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct RoutineRecordView: View {
    
    var exercise: ExerciseDataModel
    
    var body: some View {
        VStack {
            HStack {
                Text(exercise.exerciseName)
                    .font(.title)
                    .bold()
                
                Spacer()
            }.padding()
            
            // exercise에 기본 세트 수는 5개로 정한다.
            // exercise에 기본 세트 수를 추가하게 된다면 추가한대로 새롭게 저장한다 (5개에서 6개로 늘리면 그 루틴의 세트 수를 6으로 만들기)
            // 세트 수 만큼 아래 추가
        }
    }
}

#Preview {
    RoutineRecordView(exercise: .init(exerciseName: "등복근", part: [.abs, .back], tool: .barbell))
}
