//
//  RoutineRecordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI
import SwiftData

struct RoutineRecordView: View {
    
    @EnvironmentObject var timer: TimerManager
    @Environment(\.modelContext) private var modelContext

    var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터
    @State var set: Int
    @State var count: [String]
    @State var kg: [String]
    @State var done: [Bool]
    
    init(selectedExercise: ExerciseDefaultModel, set: Int, count: [Int], kg: [Int], done: [Bool]) {
//        print("가져온 운동 이름:\(selectedExercise.exerciseName)")
//        print("가져온 운동 횟수:\(selectedExercise.count)")
//        print("가져온 운동 kg:\(selectedExercise.kg)")
        self.selectedExercise = selectedExercise
        self.set = set
        self.count = count.map({ count in
            return String(count)
        })
        self.kg = kg.map({ kg in
            return String(kg)
        })
        self.done = done
    }
    
    private func saveRecord(set: Int? = nil, count: [String]? = nil, kg: [String]? = nil, done: [Bool]? = nil) {
        print("변경 감지 완료")
        if let sets = set {
            selectedExercise.set = sets
        }
        if count != nil {
            selectedExercise.count = count?.map({ c in
                return Int(c)
            }) as! [Int]
        }
        if kg != nil {
            selectedExercise.kg = kg?.map({ k in
                return Int(k)
            }) as! [Int]
        }
        if let dones = done {
            selectedExercise.done = dones
        }
        modelContext.insert(selectedExercise.exerciseRoutineContainer!)
    }
    
    // 키보드를 내리는 함수
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // 데이터를 가져오는데 selectedExercise에 해당하는 루틴의 기록을 가져와야 한다.
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedExercise.exerciseName)//.exerciseName)
                    .font(.title)
                    .bold()
                
                Spacer()
            } //HSTACK
            .padding()
            
            HStack {
                VStack {
                    HStack(alignment: .top, spacing: 0) {
                        VStack {
                            Text("세트")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(1..<selectedExercise.set+1) { set in
                                Text(String(set))
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                            }
                        } //HSTACK
                        
                        VStack {
                            Text("KG")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.kg.enumerated()), id: \.offset) { index, kg in
                                TextField("\(kg)", text: $kg[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
                                        saveRecord(kg: self.kg)
                                    }
                            }
                        } //VSTACK
//                        Array(data.enumerated())
                        VStack {
                            Text("횟수")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
                                TextField("\(count)", text: $count[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
                                        saveRecord(count: self.count)
                                    }
                            }
                        } //VSTACK
                        
                        VStack {
                            Text("완료")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
                                Button(action: {
                                    // `selectedExercise.done` 배열의 `index`에 해당하는 값을 toggle 처리
                                    self.done[index].toggle()
                                    saveRecord(done: self.done)
                                }, label: {
                                    Image(systemName: self.done[index] ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(self.done[index]
                                                         ? .green : .gray)
                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                })
                            }
                        } //VSTACK
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                Spacer()
            }
            Spacer()
            
            if timer.timerOn {
                if let data = timer.exerciseRoutineContainer {
                    TimerView(exerciseContainer: data)
                }
            }
        } //VSTACK
        .onTapGesture {
            hideKeyboard()
        }
//        .onChange(of: kg) { oldValue, newValue in
//            print("값이 변한걸 인지는 하는데?11")
//            timer.exerciseRoutineContainer = selectedExercise.exerciseRoutineContainer
//            selectedExercise.kg = kg.map({ kg in
//                return Int(kg) ?? 999
//            })
//        }
//        .onChange(of: count) { oldValue, newValue in
//            print("count는 \(oldValue)에서 \(newValue)로 바뀜")
//            timer.exerciseRoutineContainer = selectedExercise.exerciseRoutineContainer
//            selectedExercise.count = count.map({ count in
//                return Int(count) ?? 999
//            })
//            print("저장된 count: \(selectedExercise.count.description)")
//
//        }
//        .onChange(of: done) { oldValue, newValue in
//            print("값이 변한걸 인지는 하는데?33")
//            timer.exerciseRoutineContainer = selectedExercise.exerciseRoutineContainer
//            selectedExercise.done = done
//        }
//        .onChange(of: set) { oldValue, newValue in
//            selectedExercise.set = set
//            timer.exerciseRoutineContainer = selectedExercise.exerciseRoutineContainer
//        }
//        .onChange(of: timer.exerciseRoutineContainer?.exerciseDefaultModel.first?.count) { a, b in
//            print("값이 변한걸 인지는 하는데?🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲🥲")
//        }
    }
    
}
    

struct RoutineRecordScreen: View {
    
    @Query private var routineContainer: [ExerciseRoutineContainer]
    
    var body: some View {
        RoutineRecordView(selectedExercise: ExerciseDefaultModel(exerciseName: "백익스텐션", part: [.abs, .wholeBody], tool: .bodyWeight), set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])
    }
}

#Preview { @MainActor in
    RoutineRecordScreen()
        .modelContainer(previewRoutineContainer)
        .environmentObject(TimerManager())
}
