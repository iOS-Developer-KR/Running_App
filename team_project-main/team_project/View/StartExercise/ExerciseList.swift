//
//  ExerciseList.swift
//  team_project
//
//  Created by Taewon Yoon on 10/29/23.
//

import SwiftUI

struct ExerciseList: View {
    private var exer = [Exercise(name: "이두"),
                        Exercise(name: "삼두"),
                        Exercise(name: "하체"),
                        Exercise(name: "등"),
                        Exercise(name: "가슴")]
    @State var tmp = Set<UUID>()
    @State var checked: Bool = false
    var body: some View {
        List(exer, selection: $tmp) { e in
            HStack {
                Button(action: {
                    print("눌렸다")
                    checked.toggle()
                }, label: {
                    Image(systemName: checked ? "checkmark.circle.fill" : "checkmark.circle")
                })
                Text(e.name)
            }
        }.navigationTitle("오늘 조질곳")
            .toolbar { EditButton() }
            
    }
}

#Preview {
    ExerciseList()
}

struct Exercise: Identifiable, Hashable {
    let name: String
    let id = UUID()
}
