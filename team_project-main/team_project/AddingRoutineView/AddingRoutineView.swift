//
//  AddingRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI
import SwiftData

struct AddingRoutineView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var dbContext
    @State var part: ExercisePart?
    @State var tool: ExerciseTool?
    @State var textfield: String = ""
    @State private var selectedExercises: [ExerciseDefaultModel] = []
    @Query var exerciseData: [ExerciseRoutineContainer]
    var exercise: ExerciseRoutineContainer? // 만약에 기존에 있던 저장소에 추가하려면 존재 / 처음이라면 nil이 들어있을 것임

    //MARK: FUNC

    func saveRoutine() {
        // 만일 새로운 데이터라면
        print("짤린부분0")
        guard let existData = exercise else {
            print("새롭게 추가하는거")
            let newExerciseRoutineContainer = ExerciseRoutineContainer(routineName: "루틴1", exerciseDefaultModel: selectedExercises)
            print("짤린부분1")
            newExerciseRoutineContainer.exerciseDefaultModel.forEach { ExerciseDataModel in
                print("새로추가한 이름:\(ExerciseDataModel.exerciseName)")
                print("새로추가한 횟수:\(ExerciseDataModel.count.description)")
                print("새로추가한 도구:\(ExerciseDataModel.tool.rawValue)")
                print("새로추가한 무게:\(ExerciseDataModel.kg.description)")
            }
            print("짤린부분2")
            dbContext.insert(newExerciseRoutineContainer)
            return
        }
        // 만약 기존에 존재했던 데이터라면
        selectedExercises.forEach { ExerciseModel in
            if !(existData.exerciseDefaultModel.contains(where: { $0.exerciseName == ExerciseModel.exerciseName })) {
                exercise?.exerciseDefaultModel.append(ExerciseModel)
            }
        }
        
//        guard let existData = exercise else {
//            let newExercise = Exercise(routineName: "루틴1", routines: selectedExercises)
//            dbContext.insert(newExercise)
//            return
//        }
        
        
//        // 기존에 있던 데이터라면 수정해야되는 것이 맞다.
//        let id = exercise?.id
//        let predicate = #Predicate<ExerciseRoutineContainer> { $0.id == id }
//        let descriptor = FetchDescriptor<ExerciseRoutineContainer>(predicate: predicate)
//        if let count = try? dbContext.fetchCount(descriptor), count > 0 {
//            // 만약 존재했다면 기존에 있던 루틴에 추가해준다
//            exercise?.routines += selectedExercises
//        }
        
        
    }

    // 만약 루틴에 추가한다면 exercise에 데이터가 있다면 추가한 루틴은 없어야한다.
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                }).padding(.leading, 10)
                SearchBar(text: $textfield)
            }.padding(10)
            
            PartSearchMenuView(part: $part, selectedColor: .orange)
            ToolSearchMenuView(tool: $tool, selectedColor: .green)
            ExerciseListView(targetPart: $part, targetTool: $tool, selectedExercises: $selectedExercises, existedExercise: exercise)
                
            
        }
//        .onAppear(perform: {
//            print("여기에는 \(exercise?.routines.count)개가 들어있다")
//        })
        .navigationBarBackButtonHidden()
        .onChange(of: selectedExercises) { oldValue, newValue in
            print("개수 변했다: \(newValue.count)")
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                                        
                    Button(action: {}, label: {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 30, height: 33)
                    })
                    .padding()
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.red)
                    .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    Button(action: {
                        // 데이터 저장하기
                        print("루틴 저장하기")
                        saveRoutine()
                        dismiss()
                    }, label: {
                        HStack {
                            if !selectedExercises.isEmpty {
                                Text("\(selectedExercises.count)")
                                    .font(.title)
                                    .bold()
                            }
                            Text("운동 추가")
                                .font(.title)
                                .bold()
                        }
                        .frame(width: 170, height: 33, alignment: .bottom)

                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.white)
                    .foregroundStyle(Color.red)
                    .opacity(selectedExercises.isEmpty ? 0 : 1)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .frame(width: 30, height: 33)
                    })
                    .padding()
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.brown)
                    .foregroundStyle(Color.white)
                    .opacity(selectedExercises.isEmpty ? 0 : 1)

                    
//                    Spacer()

                }
            }
        }
    }
}

#Preview {
    AddingRoutineView(part: .chest, tool: .machine, textfield: "")
//        .modelContainer(PreviewContainer.container)
}
