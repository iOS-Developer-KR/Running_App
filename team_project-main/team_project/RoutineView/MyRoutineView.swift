//
//  MyRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI
import SwiftData

struct MyRoutineView: View {
    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @Query var exerciseData: [Exercise]
    @State private var exerciseParts: [ExercisePart] = [] // 중복 없는 파트 목록을 저장할 변수
    
    var body: some View {
        VStack {
            
            List(exerciseData) { exercise in
                HStack {
                    // 이미지 집어넣는곳
                    
                    NavigationLink {
                        RoutineListView(exercise: exercise)
                    } label: {
                        VStack {
                            HStack {
                                Text(exercise.routineName)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .font(.title)
                                Spacer()
                            }
                            // 파트 목록을 표시
                            HStack {
                                ForEach(updateExerciseParts(from: exercise), id: \.self) { data in
                                    Text(data.rawValue)
                                        .foregroundStyle(.green)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            
        }.padding(10)
        
        
        
        
        //        .frame(minHeight: minRowHeight * 3)
    }
    
    // 중복 없는 파트 데이터를 업데이트하는 메소드
    private func updateExerciseParts(from exercise: Exercise) -> [ExercisePart] {
        var partsSet = Set<ExercisePart>()
        exercise.routines.forEach { routine in
            routine.part.forEach { part in
                partsSet.insert(part)
            }
        }
        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
    }
}

#Preview {
    MyRoutineView()
        .modelContainer(PreviewContainer.container)
}
