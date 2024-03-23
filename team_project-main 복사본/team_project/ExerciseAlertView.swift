//
//  AlertView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI
import SwiftData

struct ExerciseAlertView: View {
    @Environment(\.modelContext) var dbContext
    @Query var exerciseRecordContainer: [ExerciseRoutineContainer]
    
    @EnvironmentObject var timer: TimerManager
    var pausedImage = "stop.fill"
    var pausedTitle = "운동 중단"
    var pausedText = "운동을 중단하면 기록이 저장되지 않습니다. 운동을 중단하시겠습니까?"
    
    var stoppedImage = "flag.fill"
    var stoppedTitle = "운동 완료"
    var stoppedText = "기록이 저장되고 결과 페이지로 이동합니다."
    
    
    func saveRecord() {
        guard let existData = timer.exerciseRoutineContainer else {
            print("존재하지 않는 데이터라서 저장할 수 없습니다")
            return
        }
        let recordContainer = ExerciseRecordContainer(recordDate: Date(), totalTime: 333)
        let recordDataModel = existData.exerciseDefaultModel.map { defaultModel in
            ExerciseRecordModel(
//                recordContainer: recordContainer,
                exerciseName: defaultModel.exerciseName,
                part: defaultModel.part,
                tool: defaultModel.tool,
                set: defaultModel.set,
                count: defaultModel.count,
                kg: defaultModel.kg,
                done: defaultModel.done
            )
        }
        
//        let recordContainer = ExerciseRecordContainer(recordDate: Date(), totalTime: 5, exerciseRecordModel: recordDataModel)

        print("기록 저장중")
        print("저장하는 값들")
        recordDataModel.forEach { ExerciseDefaultModel in
            print(ExerciseDefaultModel.exerciseName)
            print(ExerciseDefaultModel.count)
            print(ExerciseDefaultModel.done)
            print(ExerciseDefaultModel.kg)
        }
        print("저장되는 값들")
        recordContainer.exerciseRecordModel = recordDataModel
        
        dbContext.insert(recordContainer)
        do {
            try dbContext.save()
        } catch {
            print("저장하는데 에러발생")
        }
        print("기록 저장완료")
        
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
                    } label: {
                        Text("취소")
                    }
                    .padding()
                    
                    Button {
                        timer.stop()
                        timer.timerOn = false
                        saveRecord()
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
