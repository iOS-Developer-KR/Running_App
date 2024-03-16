//
//  ExerciseModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import SwiftUI
import Observation


struct ExerciseModel {
//    let parts = ["전체", "가슴", "등", "어깨", "삼두", "이두", "전완", "복근", "둔근", "햄스트링", "대퇴사두", "승모", "종아리"]
//    let tools = ["전체", "맨몸", "유산소", "스트레칭", "덤벨", "바벨", "스미스머신", "밴드", "머신", "케이블"]
    let parts = ExercisePart.allCases
    let tools = ExerciseTool.allCases
}


enum ExercisePart: String, CaseIterable {
    case wholeBody = "전체"
    case chest = "가슴"
    case back = "등"
    case shoulders = "어깨"
    case triceps = "삼두"
    case biceps = "이두"
    case forearms = "전완"
    case abs = "복근"
    case glutes = "둔근"
    case hamstrings = "햄스트링"
    case quadriceps = "대퇴사두"
    case trapezius = "승모"
    case calves = "종아리"
}

enum ExerciseTool: String, CaseIterable {
    case wholeBody = "전체"
    case bodyWeight = "맨몸"
    case cardio = "유산소"
    case stretching = "스트레칭"
    case dumbbell = "덤벨"
    case barbell = "바벨"
    case smithMachine = "스미스머신"
    case resistanceBand = "벤드"
    case machine = "머신"
    case cable = "케이블"
}


struct ExerciseDataModel: Hashable {
    var exerciseName: String
    var part: [ExercisePart]
    var tool: ExerciseTool
}

struct ExerciseData {
    static let lowingmachine = ExerciseDataModel(exerciseName: "lowingmachine", part: [.hamstrings, .quadriceps], tool: .machine)

    static let dumbbellDeclineBenchPress = ExerciseDataModel(exerciseName: "Dumbbell Decline Bench Press", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellFlatBenchPress = ExerciseDataModel(exerciseName: "Dumbbell Flat Bench Press", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellInclineBenchPress = ExerciseDataModel(exerciseName: "Dumbbell Incline Bench Press", part: [.chest, .triceps], tool: .dumbbell)
    
    static let barbellDeclineBenchPress = ExerciseDataModel(exerciseName: "Barbell Decline Bench Press", part: [.chest, .triceps], tool: .barbell)
    static let barbellFlatBenchPress = ExerciseDataModel(exerciseName: "Barbell Flat Bench Press", part: [.chest, .triceps], tool: .barbell)
    static let barbellInclineBenchPress = ExerciseDataModel(exerciseName: "Barbell Incline Bench Press", part: [.chest, .triceps], tool: .barbell)
    
    static let allExercises = [lowingmachine, dumbbellDeclineBenchPress, dumbbellFlatBenchPress, dumbbellInclineBenchPress, barbellDeclineBenchPress, barbellFlatBenchPress, barbellInclineBenchPress]
}





