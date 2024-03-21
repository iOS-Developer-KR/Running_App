//
//  TimerView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timer: TimerManager
    @State var rotation: CGFloat = 0.0
    
    var body: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 20, style: .continuous)
//                .frame(width: , height: 40)
//                .backgroundStyle(.color1)
//            Color(.systemBackground)
            HStack {
                
                VStack {
                    HStack {
                        Text("\(timer.exerciseRoutineContainer?.routineName ?? "")")
                        Spacer()
                    }
                    HStack {
                        Text("\(timer.elapsedTime2)")
                        Spacer()
                    }
                }
                
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "pause.fill")
                })
                .padding()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "stop.fill")
                })
                .padding()
                
            }
            .padding()
            .foregroundStyle(.color1)
//            .backgroundStyle(.color2)
        }
    }
}

#Preview {
    TimerView()
        .environmentObject(TimerManager())
}
