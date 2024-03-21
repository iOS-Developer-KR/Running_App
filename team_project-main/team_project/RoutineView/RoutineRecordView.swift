//
//  RoutineRecordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI
import SwiftData

struct RoutineRecordView: View {
    
    var selectedExercise: ExerciseModel // 선택된 단독 데이터

    
    init(selectedExercise: ExerciseModel) {
        self.selectedExercise = selectedExercise
//        self.record = record
    }
    
// 데이터를 가져오는데 selectedExercise에 해당하는 루틴의 기록을 가져와야 한다.
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedExercise.exerciseName)
                    .font(.title)
                    .bold()
                
                Spacer()
            }.padding()
            
            HStack {
                VStack {
                    HStack(alignment: .top, spacing: 0) {
                            VStack {
                                Text("세트")
                                    .frame(minWidth: 50, alignment: .center)
                                ForEach(1...(selectedExercise.set), id: \.self) { data in
                                    Text("\(data)")
                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                }
                            }
                            
                            VStack {
                                Text("KG")
                                    .frame(minWidth: 50, alignment: .center)
                                ForEach(selectedExercise.kg, id: \.self) { data in
                                    Text("\(data)")
                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                }
                            }

                            VStack {
                                Text("횟수")
                                    .frame(minWidth: 50, alignment: .center)
                                ForEach(selectedExercise.count, id: \.self) { data in
                                    Text("\(data)")
                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                }
                            }
                            
                            VStack {
                                Text("완료")
                                    .frame(minWidth: 50, alignment: .center)
                                ForEach(selectedExercise.done, id: \.self) { data in
                                    Button(action: {
                                        // 여기서 finished 배열의 index에 해당하는 값을 toggle 처리해야 함
                                        // 예: self.selectedExercise.exercise?.finished[index].toggle()
                                    }, label: {
                                        Image(systemName: data ? "checkmark.circle.fill" : "circle")
                                            .foregroundStyle(data ? .green : .gray)
                                            .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    })
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)

//                    HStack {
//                        VStack {
//                            Text("세트")
//                            
//                            ForEach(0...(selectedExercise.exercise?.set ?? 5), id: \.self) { data in
//                                Text("\(data)")
//                                    .frame(width: 50, alignment: .center) // 위와 동일한 너비를 지정
//                            }
//                        }
//                        
//                        VStack {
//                            Text("KG")
//                                .frame(width: 50, alignment: .center) // 너비를 지정
//                            ForEach(selectedExercise.exercise?.kg ?? [0,0,0,0,0], id: \.self) { data in
//                                Text("\(data)")
//                                    .frame(width: 50, alignment: .center) // 위와 동일한 너비를 지정
//                            }
//                        }
//                        
//                        VStack {
//                            Text("횟수")
//                                .frame(width: 50, alignment: .center) // 너비를 지정
//                            ForEach(selectedExercise.exercise?.count ?? [5,5,5,5,5], id: \.self) { data in
//                                Text("\(data)")
//                                    .frame(width: 50, alignment: .center) // 위와 동일한 너비를 지정
//                            }
//                        }
//                        
//                        VStack {
//                            Text("완료")
//                                .frame(width: 50, alignment: .center) // 너비를 지정
//                            ForEach(selectedExercise.exercise?.finished ?? [false, false, false, false, false], id: \.self) { data in
//                                Button(action: {
////                                    data.toggle()
//                                }, label: {
//                                    Image(systemName: data ? "checkmark.circle.fill" : "circle")
//                                        .foregroundStyle(data ? .green : .gray)
//                                        .frame(width: 50, alignment: .center) // 위와 동일한 너비를 지정
//                                })
//
//                            }
//                        }
//                    }
                }
                
                Spacer()
            }
            Spacer()
        }
    }

}



#Preview {
    RoutineRecordView(selectedExercise: .init(exerciseName: "백익스텐션", part: [.abs,.back], tool: .bodyWeight))
        .modelContainer(PreviewContainer.container)
}
