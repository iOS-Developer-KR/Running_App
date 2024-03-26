//
//  MyRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI
import SwiftData

struct MyRoutineView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var exerciseParts: [ExercisePart] = [] // 중복 없는 파트 목록을 저장할 변수
    @Query var exerciseData: [ExerciseRoutineContainer] // 모든 루틴이 들어있는 컨테이너
    
    var body: some View {
        VStack {
            
            List {
                ForEach(exerciseData, id: \.self) { exercise in
                    HStack {
                        // 이미지 집어넣는곳
                        NavigationLink {
                            RoutineListView(exerciseContainer: exercise)
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
                }.onDelete(perform: { indexSet in
                    removeList(at: indexSet)
                })
            }.padding(10)
        }
    }
    
    func removeList(at offsets: IndexSet) {
//           users.remove(atOffsets: offsets)
        for i in offsets {
            let data = exerciseData[i]
            modelContext.delete(data)
        }
        
    }

    
    // 중복 없는 파트 데이터를 업데이트하는 메소드
    private func updateExerciseParts(from exercise: ExerciseRoutineContainer) -> [ExercisePart] {
        var partsSet = Set<ExercisePart>()
        exercise.exerciseDefaultModel?.forEach { ExerciseModel in
            ExerciseModel.part.forEach({ ExercisePart in
                partsSet.insert(ExercisePart)
            })
        }
        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
    }
}

struct RoutineContainerScreen: View {
    
    @Query var exerciseData: [ExerciseRoutineContainer]
    
    var body: some View {
        MyRoutineView()
    }
}

#Preview { @MainActor in
    NavigationStack {
        MyRoutineView()
            .modelContainer(previewRoutineContainer)
    }
}
