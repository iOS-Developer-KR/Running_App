//
//  AlertView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI

struct ExerciseAlertView: View {
    @EnvironmentObject var timer: TimerManager
    @Environment(\.modelContext) var dbContext

    var pausedImage = "stop.fill"
    var pausedTitle = "운동 중단"
    var pausedText = "운동을 중단하면 기록이 저장되지 않습니다. 운동을 중단하시겠습니까?"
    
    var stoppedImage = "flag.fill"
    var stoppedTitle = "운동 완료"
    var stoppedText = "기록이 저장되고 결과 페이지로 이동합니다."
    
    func saveRecord() {
        if let exerciseContainer = timer.exerciseRoutineContainer {
            let exerciseDataModel = exerciseContainer.exerciseDataModel
            let recordContainer = ExerciseRecordContainer(routinContainer: exerciseContainer, exerciseDataModel: exerciseDataModel, recordDate: Date(), totalTime: Int(timer.elapsedTime))
            print("저장될 운동이름:\(recordContainer.exerciseDataModel.first?.exerciseName ?? "")")
            print("저장될 운동횟수:\(recordContainer.exerciseDataModel.first?.count.description ?? "")")
            print("저장될 운동중량:\(recordContainer.exerciseDataModel.first?.kg.description ?? "")")
            exerciseContainer.routines.append(recordContainer)
            
            dbContext.insert(exerciseContainer)
        }
    }
    
    var body: some View {
        ZStack {
            Color.darkRed
            VStack {
                Image(systemName: timer.stopped ? stoppedImage : pausedImage)
                    .foregroundStyle(.red)
                    .padding(.top)
                
                Text(timer.stopped ? stoppedTitle : pausedTitle)
                    .padding()
                
                HStack {
                    Spacer()
                    Text(timer.stopped ? stoppedText : pausedText)
                        .lineLimit(nil)
                        .frame(height: 50)
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                
                
                HStack {
                    Button {
                        timer.resume()
                        //timer.timerOn && timer.stopped
                    } label: {
                        Text("취소")
                    }
                    .padding()
                    
                    Button {
                        saveRecord()
                        timer.stop()
                        timer.timerOn = false
                        
                    } label: {
                        Text("확인")
                    }
                }
            }
        }
        .frame(width: 300, height: 230)
        .clipShape(.rect(cornerRadius: 40))
        .shadow(radius: 10)
        .transition(.scale) // 알림창 등장 애니메이션. 원하는 대로 변경 가능

    }
}

#Preview {
    ExerciseAlertView()
}
