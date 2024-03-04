//
//  SummeryChartView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/13/23.
//

import SwiftUI
import Charts

struct SummeryChartView: View {
    var tmp = Exce().info
    var body: some View {
        Chart {
            ForEach(Exce().info, id: \.id) { data in
                LineMark(x: .value("exerciseDate", data.exerciseDate!), y: .value("exerciseTime", data.exerciseTime))
            }
         }.frame(height: 300)
    }
}

#Preview {
    SummeryChartView()
}
