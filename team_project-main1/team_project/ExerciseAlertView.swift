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
//    @Query var exerciseRecordContainer: [ExerciseRoutineContainer]
    
    @EnvironmentObject var timer: TimerManager
    var pausedImage = "stop.fill"
    var pausedTitle = "운동 중단"
    var pausedText = "운동을 중단하면 기록이 저장되지 않습니다. 운동을 중단하시겠습니까?"
    
    var stoppedImage = "flag.fill"
    var stoppedTitle = "운동 완료"
    var stoppedText = "기록이 저장되고 결과 페이지로 이동합니다."
    
    
    func saveRecord() {
        
        var recordModels: [ExerciseRecordModel] = []
        
        timer.exerciseRoutineContainer?.exerciseDefaultModel.forEach({ ed in
            print("타이머값 count: \(ed.count)")
            print("타이머값 kg: \(ed.kg)")
            print("타이머값 done: \(ed.done)")
            let exerciseName: String = ed.exerciseName
            let part: [ExercisePart] = ed.part
            let tool: ExerciseTool = ed.tool
            let set: Int = ed.set
            let count: [Int] = ed.count
            let kg: [Int] = ed.kg
            let done: [Bool] = ed.done
            print("새로 추가ㄷ:\(done)")

            let exerciseRecordModel = ExerciseRecordModel(exerciseName: exerciseName, part: part, tool: tool, set: set, count: count, kg: kg, done: done)
            recordModels.append(exerciseRecordModel)
            print("새로 추가된값:\(exerciseRecordModel.exerciseName)")
            print("새로 추가된값:\(exerciseRecordModel.count)")
            print("새로 추가된값:\(exerciseRecordModel.tool)")
            print("새로 추가된값:\(exerciseRecordModel.kg)")
            print("새로 추가된값:\(exerciseRecordModel.done)")
            
        })
        
        var dm: [ExerciseRecordModel] = []
//        timer.exerciseRoutineContainer?.exerciseDefaultModel.forEach({ edm in
//
//            let recordModel = ExerciseRecordModel(exerciseName: name, part: part, tool: tool, set: set, count: count, kg: kg, done: done)
//            dm.append(recordModel)
//        })
        let name = timer.exerciseRoutineContainer?.routineName ?? "이름 없다"
        
            dm.forEach({ ExerciseDefaultModel in
                print("타이머값 count: \(ExerciseDefaultModel.count)")
                print("타이머값 kg: \(ExerciseDefaultModel.kg)")
                print("타이머값 done: \(ExerciseDefaultModel.done)")
            })

        let newRecord = ExerciseRecordContainer(recordDate: dateformat.string(from: timer.startTime ?? Date()), totalTime: Int(timer.elapsedTime), routineName: name, exerciseRecordModel: dm)
        

        dbContext.insert(newRecord)

        
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
