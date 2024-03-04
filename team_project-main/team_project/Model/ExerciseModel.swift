//
//  ExerciseModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import SwiftUI
import Observation


class ExerciseModel {
    let httpClient = HTTPClient()
    
    func getSummery() async -> [ExerciseData] {
//        let query = URLQueryItem(name: "", value: "")
//        var request = URLRequest(url: Constants().exercise!)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        request.httpBody = try? JSONEncoder().encode()
        do {
            let request = Resource(url: Constants().exercise!, method: .getnothing, modelType: [ExerciseData].self)
            return try await httpClient.load(request)
        } catch {
            print("운동데이터 가져오기 에러 \(error)")
        }
//        return [ExerciseData(username: "", exerciseDate: "", exerciseTime: 0, exerciseCount: 0, exerciseName: "")]
        return [ExerciseData(id: 1, username: "", exerciseDate: "", exerciseTime: 0, exerciseCount: 0, exerciseName: "")]
    }
}


//struct ExerciseData: Codable, Identifiable {
//    var id = UUID()
//    var username: String
//    var exerciseDate: String
//    var exerciseTime: Int
//    var exerciseCount: Int
//    var exerciseName: String
//}
struct ExerciseData: Codable {
    var id: Int
    var username: String
    var exerciseDate: String?
    var exerciseTime: Int
    var exerciseCount: Int
    var exerciseName: String
}



class Exce {
    var info: [ExerciseData] = [
//        ExerciseData(username: "tae", exerciseDate: "1030", exerciseTime: 54, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1031", exerciseTime: 32, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1101", exerciseTime: 14, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1102", exerciseTime: 34, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1103", exerciseTime: 64, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1104", exerciseTime: 84, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1105", exerciseTime: 104, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1106", exerciseTime: 54, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1107", exerciseTime: 32, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1108", exerciseTime: 14, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1109", exerciseTime: 34, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1110", exerciseTime: 64, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1111", exerciseTime: 84, exerciseCount: 1, exerciseName: "pushup"),
//        ExerciseData(username: "tae", exerciseDate: "1112", exerciseTime: 104, exerciseCount: 1, exerciseName: "pushup")
    ]
}

