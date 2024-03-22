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
    
    var selectedExercise: ExerciseModel // 선택된 단독 데이터
    var set: Int
    @State var count: [Int]
    @State var kg: [Int]
    @State var done: [Bool]
    
    
    init(selectedExercise: ExerciseModel, set: Int, count: [Int], kg: [Int], done: [Bool]) {
        
        self.selectedExercise = selectedExercise
        self.set = set
        self.count = count
        self.kg = kg
        self.done = done
    }
    
    // 키보드를 내리는 함수
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    private func bindingForKg(at index: Int) -> Binding<String> {
//        print("인덱스:\(index), Kg:\(kg.description)")
        return Binding<String>(
            get: {
                //                if let kgValue = self.kg[index] {
                return String(self.kg[index])
                //                }
                //                return ""
            },
            set: {
                if let newValue = Int($0) {
                    self.kg[index] = newValue
                }
            }
        )
    }
    
    private func bindingForCount(at index: Int) -> Binding<String> {
        Binding<String>(
            get: {
                //                if let kgValue = self.count[index] {
                return String(self.count[index])
                //                }
                //                return ""
            },
            set: {
                if let newValue = Int($0) {
                    self.count[index] = newValue
                }
            }
        )
    }
    
    private func bindingForDone(at index: Int) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                // 옵셔널 체이닝을 사용하여 안전하게 값을 가져옵니다. 옵셔널이 아니므로 if let은 필요 없습니다.
                self.done[index]
            },
            set: {
                // Bool($0)은 필요 없습니다. $0 자체가 이미 Bool 타입입니다.
                self.done[index] = $0
            }
        )
    }
    
    
    // 데이터를 가져오는데 selectedExercise에 해당하는 루틴의 기록을 가져와야 한다.
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedExercise.exerciseName)
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
                            ForEach(1...set, id: \.self) { data in
                                Text(data.formatted())
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                            }
                        } //HSTACK
                        
                        VStack {
                            Text("KG")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(0..<set, id: \.self) { index in
                                TextField("0", text: bindingForKg(at: index))
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                            }
                        } //VSTACK
                        
                        VStack {
                            Text("횟수")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(0..<set, id: \.self) { index in
                                TextField("0", text: bindingForCount(at: index))
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                            }
                        } //VSTACK
                        
                        VStack {
                            Text("완료")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(0..<set, id: \.self) { index in
                                Button(action: {
                                    // `selectedExercise.done` 배열의 `index`에 해당하는 값을 toggle 처리
                                    self.done[index].toggle()
                                }, label: {
                                    Image(systemName: done[index] ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(done[index] ? .green : .gray)
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
    }
    
}



#Preview {
    RoutineRecordView(selectedExercise: .init(exerciseName: "백익스텐션", part: [.abs,.back], tool: .bodyWeight), set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])
        .modelContainer(PreviewContainer.container)
}
