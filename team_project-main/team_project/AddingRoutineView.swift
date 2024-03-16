//
//  AddingRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI

struct AddingRoutineView: View {
    @State var textfield: String
    @Environment(\.dismiss) private var dismiss
//    @State var part = ExerciseModel().parts
//    @State var tool = ExerciseModel().tools
    @State var part: ExercisePart
    @State var tool: ExerciseTool
    
    @State private var selectedItem: String?
    
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
            
            ExerciseListView(targetPart: $part, targetTool: $tool)
            
        }
        Spacer()
        
        .navigationBarBackButtonHidden()
        .onChange(of: part) { oldValue, newValue in
            print("변했다:\(part), \(tool)")
        }
    }
}

#Preview {
    AddingRoutineView(textfield: "", part: .chest, tool: .machine)
}
