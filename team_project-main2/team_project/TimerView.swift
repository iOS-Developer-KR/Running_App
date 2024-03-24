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
    var exerciseContainer: ExerciseRoutineContainer
    
    func recordSaveExercise() {
        
    }
    
    var body: some View {

            
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
                    timer.resume()
                }, label: {
                    Image(systemName: timer.timerOn ? "pause.fill" : "play.fill")
                })
                .padding()
                
                Button {
                    timer.pause()
                    timer.stopped.toggle()
                    print(timer.stopped)
                } label: {
                    Image(systemName: "stop.fill")
                }
                
                
                .padding()
                
                
                
            }
            .padding()
            .foregroundStyle(.color1)
            

    }
}

#Preview {
    TimerView(exerciseContainer: PreviewData().previewExerciseRoutineContainer)
        .modelContainer(PreviewContainer.container)

        .environmentObject(TimerManager())
}
