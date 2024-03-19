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
    @State private var selectedExercises: [ExerciseDataModel] = []
    @Query var exerciseData: [Exercise]

    //MARK: FUNC

    func saveRoutine() {
        let exercise = Exercise(routineName: "루틴1", routines: selectedExercises)
        dbContext.insert(exercise)
    }

    
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
            ExerciseListView(targetPart: $part, targetTool: $tool, selectedExercises: $selectedExercises)
            
        }
        .navigationBarBackButtonHidden()
        .onChange(of: selectedExercises) { oldValue, newValue in
            print("개수 변했다: \(newValue.count)")
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                    
//                    Spacer()
                    
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
        .modelContainer(PreviewContainer.container)
}
