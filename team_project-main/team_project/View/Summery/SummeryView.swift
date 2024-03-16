//
//  SummeryView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI
import Charts

struct SummeryView: View {
    var model = ExerciseModel()
    @State private var summeryData: [ExerciseData]?
    @State private var currentData: [ExerciseData]?
    
    var body: some View {
        VStack {
            Chart {
                ForEach(Exce().info, id: \.id) { data in
                    LineMark(x: .value("exerciseDate", data.exerciseDate!), y: .value("exerciseTime", data.exerciseTime))
                }
             }.frame(height: 300)
             .padding()
             Spacer()
          }
        .onAppear {
            Task {
//                summeryData = Exce().info
//                print(summeryData?.first)
                summeryData = await model.getSummery()
                
            }
        }
//        List
    }
}

#Preview {
    SummeryView()
}
