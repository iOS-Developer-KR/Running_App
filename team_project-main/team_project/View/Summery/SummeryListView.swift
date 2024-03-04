//
//  SummeryListView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/13/23.
//

import SwiftUI

struct SummeryListView: View {
//    var exerciseData
    var body: some View {
        List(Exce().info, id: \.id) { ex in
            Text(ex.exerciseName)
        }
    }
}

#Preview {
    SummeryListView()
}
