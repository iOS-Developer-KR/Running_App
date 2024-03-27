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

    @Bindable var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터
//    @State var set: Int
//    @State var count: [Int]
//    @State var kg: [Int]
//    @State var done: [Bool]
    
    
//    @Binding var path: NavigationPath

//    init(selectedExercise: ExerciseDefaultModel, set: Int, count: [Int], kg: [Int], done: [Bool]) {
////        print("가져온 운동 이름:\(selectedExercise.exerciseName)")
////        print("가져온 운동 횟수:\(selectedExercise.count)")
////        print("가져온 운동 kg:\(selectedExercise.kg)")
//        self.selectedExercise = selectedExercise
//        self.set = set
//        self.count = count.map({ count in
//            return String(count)
//        })
//        self.kg = kg.map({ kg in
//            return String(kg)
//        })
//        self.done = done
//        
//    }
//    init(selectedExercise: ExerciseDefaultModel) {
//        self.selectedExercise = selectedExercise
//        self.set = selectedExercise.set
//        self.count = selectedExercise.count
//        self.kg = selectedExercise.kg
//        self.done = selectedExercise.done
//    }
    

    
//    private func saveRecord(set: Int? = nil, count: [String]? = nil, kg: [String]? = nil, done: [Bool]? = nil) {
//        print("변경 감지 완료")
//        if let sets = set {
//            selectedExercise.set = sets
//            print("새로 저장하는 세트 수:\(selectedExercise.set)")
//        }
//        if count != nil {
//            selectedExercise.count = count?.map({ c in
//                return Int(c)
//            }) as! [Int]
//            print("새로 저장하는 카운트 수:\(selectedExercise.count)")
//
//        }
//        if kg != nil {
//            selectedExercise.kg = kg?.map({ k in
//                return Int(k)
//            }) as! [Int]
//            print("새로 저장하는 중량 수:\(selectedExercise.kg)")
//
//        }
//        if let dones = done {
//            selectedExercise.done = dones
//            print("새로 저장하는 완료:\(selectedExercise.done)")
//        }
//    }
    
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
                                TextField("\(kg)", value: $selectedExercise.kg[index], formatter: NumberFormatter())
//                                TextField("\(kg)", text: $kg[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
//                                        saveRecord(kg: self.kg)
                                    }
                                    .onChange(of: selectedExercise.kg) { oldValue, newValue in
                                        print("변화했다 응애:\(oldValue) -> \(newValue)")
                                    }
                            }
                        } //VSTACK
//                        Array(data.enumerated())
                        VStack {
                            Text("횟수")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
                                TextField("\(count)", value: $selectedExercise.count[index], formatter: NumberFormatter())
//                                TextField("\(count)", text: $count[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
//                                        saveRecord(count: self.count)
                                    }
                            }
                        } //VSTACK
                        
                        VStack {
                            Text("완료")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
                                Button(action: {
                                    // `selectedExercise.done` 배열의 `index`에 해당하는 값을 toggle 처리
                                    selectedExercise.done[index].toggle()
//                                    saveRecord(done: self.done)
                                }, label: {
                                    Image(systemName: selectedExercise.done[index] ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(selectedExercise.done[index]
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

//        .overlay {
//            if timer.timerOn && timer.stopped {
//                Color.black.opacity(0.4)
//                    .ignoresSafeArea() // 화면 전체를 커버합니다.
//                    .allowsHitTesting(true) // 이 뷰가 사용자 입력을 받도록 합니다.
//                // 커스텀 알림창 뷰입니다. alert 상태가 true일 때만 보여집니다.
//                ExerciseAlertView()
//                
//            }
//        }
    }
    
}
    

struct RoutineRecordScreen: View {
    
    @Query private var routineContainer: [ExerciseRoutineContainer]
    
    var body: some View {
        RoutineRecordView(selectedExercise: ExerciseDefaultModel(exerciseName: "백익스텐션", part: [.abs, .wholeBody], tool: .bodyWeight))//, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])
        
//        RoutineRecordView(selectedExercise: SampleData.exerciseDefaultModel.first!, set: 5, count: [0,0,0,0,0].map({ num in
//            return String(num)
//        }), kg: [0,0,0,0,0].map({ num in
//            return String(num)
//        }), done: [false,false,false,false,false])
    }
}

#Preview { @MainActor in
    RoutineRecordScreen()
        .modelContainer(previewRoutineContainer)
        .environmentObject(TimerManager())
}
