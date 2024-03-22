//
//  Record.swift
//  team_project
//
//  Created by Taewon Yoon on 3/23/24.
//

import SwiftUI

struct Record: View {
    @State private var selectedDate: Date = Date()

    var body: some View {
       VStack {
          Text("Date: \(selectedDate.formatted(.dateTime.day().month()))")
          DatePicker("Date:", selection: $selectedDate, displayedComponents: .date)
             .labelsHidden()
             .datePickerStyle(.compact)
          Spacer()
       }.padding()
    }
}

#Preview {
    Record()
}
