//
//  RecordRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/24/24.
//

import SwiftUI
import SwiftData

struct RecordRoutineView: View {
    @Query var exerciseRecordData: [ExerciseRecordContainer]
    
    
    @State private var exerciseParts: [ExercisePart] = [] // 중복 없는 파트 목록을 저장할 변수
    
    init(date: String) {
        _exerciseRecordData = Query(filter: #Predicate<ExerciseRecordContainer> { $0.recordDate == date })
    }
    
    
    
    var body: some View {
        VStack {
            List(exerciseRecordData) { record in
                NavigationLink {
                    RecordListView(recordContainer: record)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(record.routineName)")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.orange)
                            
                            HStack {
                                ForEach(updateExerciseParts(from: record)) { part in
                                    Text(part.rawValue)
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                            }
                            
                        }
                    }
                }
            }
            
        }.padding()
            .onChange(of: exerciseRecordData) { oldValue, newValue in
                exerciseRecordData.forEach { ExerciseRecordContainer in
                    ExerciseRecordContainer.exerciseRecordModel.forEach { ed in
                        print(ed.exerciseName)
                        print(ed.kg)
                        print(ed.done)
                    }
                }
            }
    }
    
    // 중복 없는 파트 데이터를 업데이트하는 메소드
    func updateExerciseParts(from exercise: ExerciseRecordContainer) -> [ExercisePart] {
        var partsSet = Set<ExercisePart>()
        exercise.exerciseRecordModel.forEach { ExerciseModel in
            ExerciseModel.part.forEach({ ExercisePart in
                partsSet.insert(ExercisePart)
            })
        }
        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
    }
}

#Preview {
    RecordRoutineView(date: dateformat.string(from: Date()))
}
