//
//  ExerciseModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Exercise: Identifiable { // 운동루틴 모델
    var id: UUID?
    var routineName: String
    var routines: [ExerciseDataModel]
    var record: ExerciseRecord?
    
    init(routineName: String = "", routines: [ExerciseDataModel] = .init()) {
        self.id = UUID()
        self.routineName = routineName
        self.routines = routines
    }
}

@Model final class ExerciseRecord { // 운동루팅 기록 저장 모델
    
    @Relationship(deleteRule: .noAction, inverse: \Exercise.record) 
    var exercise: Exercise?
    var date: Date?
    var exerciseData: ExerciseDataModel?
    var time: Int?
    
    init(exercise: Exercise, date: Date? = nil, exerciseData: ExerciseDataModel? = nil, time: Int? = nil) {
        self.exercise = exercise
        self.date = date
        self.exerciseData = exerciseData
        self.time = time
    }
}



enum ExercisePart: String, CaseIterable, Codable, Identifiable {
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
    var id: String { self.rawValue }
}

enum ExerciseTool: String, CaseIterable, Codable {
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


struct ExerciseDataModel: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    
    var exerciseName: String
    var part: [ExercisePart]
    var tool: ExerciseTool
    var checked: Bool = false
}




struct ExerciseData {
    static let lowingmachine = ExerciseDataModel(exerciseName: "로잉 머신", part: [.hamstrings, .quadriceps], tool: .machine)
    static let dumbbellDeclineBenchPress = ExerciseDataModel(exerciseName: "덤벨 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellFlatBenchPress = ExerciseDataModel(exerciseName: "덤벨 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellInclineBenchPress = ExerciseDataModel(exerciseName: "바벨 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let barbellDeclineBenchPress = ExerciseDataModel(exerciseName: "바벨 디클라인", part: [.chest, .triceps], tool: .barbell)
    static let barbellFlatBenchPress = ExerciseDataModel(exerciseName: "바벨 플랫 벤치 프레스", part: [.chest, .triceps], tool: .barbell)
    static let barbellInclineBenchPress = ExerciseDataModel(exerciseName: "바벨 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .barbell)
    static let machineInclineBenchPress = ExerciseDataModel(exerciseName: "머신 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .machine)
    static let smithMachineBenchPress = ExerciseDataModel(exerciseName: "스미스 머신 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineDeclineBenchPress = ExerciseDataModel(exerciseName: "스미스 머신 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineInclineBenchPress = ExerciseDataModel(exerciseName: "스미스 머신 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineCloseGripBenchPress = ExerciseDataModel(exerciseName: "스미스 머신 클로즈 그립 벤치 프레스", part: [.chest, .shoulders], tool: .machine)
    static let machineChestPress = ExerciseDataModel(exerciseName: "머신 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let cableChestPress = ExerciseDataModel(exerciseName: "케이블 체스트 프레스", part: [.chest, .shoulders], tool: .cable)
    static let cableInclineChestPress = ExerciseDataModel(exerciseName: "케이블 인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .cable)
    static let bandChestPress = ExerciseDataModel(exerciseName: "밴드 체스트 프레스", part: [.chest, .shoulders], tool: .resistanceBand)
    static let dumbbellDeclineFly = ExerciseDataModel(exerciseName: "덤벨 디클라인 플라이", part: [.chest], tool: .dumbbell)
    static let dumbbellFly = ExerciseDataModel(exerciseName: "덤벨 플라이", part: [.chest], tool: .dumbbell)
    static let dumbbellInclineFly = ExerciseDataModel(exerciseName: "덤벨 인클라인 플라이", part: [.chest, .shoulders], tool: .dumbbell)
    static let machineFly = ExerciseDataModel(exerciseName: "머신 플라이", part: [.chest], tool: .machine)
    static let benchCableFly = ExerciseDataModel(exerciseName: "벤치 케이블 플라이", part: [.chest, .shoulders], tool: .cable)
    static let cableCrossoverFly = ExerciseDataModel(exerciseName: "케이블 크로스오버 플라이", part: [.chest, .shoulders], tool: .cable)
    static let inclineBenchCableFly = ExerciseDataModel(exerciseName: "인클라인 벤치 케이블 플라이", part: [.chest, .shoulders], tool: .cable)
    static let declinePushup = ExerciseDataModel(exerciseName: "디클라인 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let diamondPushup = ExerciseDataModel(exerciseName: "다이아몬드 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let hinduPushup = ExerciseDataModel(exerciseName: "힌두 후시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let inclinePushup = ExerciseDataModel(exerciseName: "인클라인 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let kneePushup = ExerciseDataModel(exerciseName: "니 푸시 업", part: [.chest, .triceps], tool: .bodyWeight)
    static let pikePushup = ExerciseDataModel(exerciseName: "파이크 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let pushup = ExerciseDataModel(exerciseName: "푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let potationPushup = ExerciseDataModel(exerciseName: "포테이션 푸시 업", part: [.chest, .triceps], tool: .bodyWeight)
    static let weightedPushup = ExerciseDataModel(exerciseName: "중량 푸시 업", part: [.chest, .shoulders], tool: .machine)
    static let lyingDumbbellPullover = ExerciseDataModel(exerciseName: "라잉 덤벨 풀오버", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellSquatBenchPress = ExerciseDataModel(exerciseName: "덤벨 스쿼즈 벤치 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let plateInclineChestPress = ExerciseDataModel(exerciseName: "플레이트 인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateDeclineChestPress = ExerciseDataModel(exerciseName: "플레이트 디클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateBenchPress = ExerciseDataModel(exerciseName: "플레이트 벤치 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateChestPress = ExerciseDataModel(exerciseName: "플레이트 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let archerPushup = ExerciseDataModel(exerciseName: "아처 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let widePushup = ExerciseDataModel(exerciseName: "와이드 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let chestStretch = ExerciseDataModel(exerciseName: "가슴 스트레칭", part: [.chest], tool: .stretching)
    static let wideGripBenchPress = ExerciseDataModel(exerciseName: "와이드 그립 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let barbellReverseGripBenchPress = ExerciseDataModel(exerciseName: "바벨 리버스 그립 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let isometricBenchPress = ExerciseDataModel(exerciseName: "정지 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let dumbbellInclineSqueezePress = ExerciseDataModel(exerciseName: "덤벨 인클라인 스쿼즈 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let diamondPress = ExerciseDataModel(exerciseName: "다이아몬드 프레스", part: [.chest, .shoulders], tool: .bodyWeight)
    static let cableInclineBenchPress = ExerciseDataModel(exerciseName: "케이블 인클라인 벤치 프레스", part: [.chest, .shoulders], tool: .cable)
    static let cableBenchPress = ExerciseDataModel(exerciseName: "케이블 벤치 프레스", part: [.chest, .shoulders], tool: .cable)
    static let dumbbellFloorHammerPress = ExerciseDataModel(exerciseName: "덤벨 플로어 해머 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let dumbbellFloorChestPress = ExerciseDataModel(exerciseName: "덤벨 플로어 체스트 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let declineChestPress = ExerciseDataModel(exerciseName: "디클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let inclineChestPress = ExerciseDataModel(exerciseName: "인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let lyingBarbellPullover = ExerciseDataModel(exerciseName: "라잉 바벨 풀오버", part: [.chest, .back], tool: .barbell)
    static let platePress = ExerciseDataModel(exerciseName: "플레이트 프레스", part: [.chest, .triceps], tool: .machine)
    static let cableCrossoverLowFly = ExerciseDataModel(exerciseName: "케이블 크로스오버 로우 플라이", part: [.chest, .shoulders], tool: .cable)
    static let compensationPushup = ExerciseDataModel(exerciseName: "보수 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let cableCrossoverHighFly = ExerciseDataModel(exerciseName: "케이블 크로스오버 하이 플라이", part: [.chest, .shoulders], tool: .cable)
    static let landmineChestPress = ExerciseDataModel(exerciseName: "랜드마인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let bandedDumbbellPress = ExerciseDataModel(exerciseName: "범델 데벨 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let inclineFly = ExerciseDataModel(exerciseName: "인클라인 플라이", part: [.chest, .shoulders], tool: .dumbbell)
    static let shoulderFoamRoller = ExerciseDataModel(exerciseName: "어깨 폼롤러", part: [.chest, .shoulders], tool: .stretching)
    static let handReleasePushup = ExerciseDataModel(exerciseName: "핸드 릴리즈 푸시 업", part: [.chest, .back], tool: .bodyWeight)
    static let cableDeclineBenchPress = ExerciseDataModel(exerciseName: "케이블 디클라인 벤치 프레스", part: [.chest, .shoulders], tool: .cable)

    static var allExercies: [ExerciseDataModel] {
        get {
            return chestExercises
        }
    }
    
    static let chestExercises = [
        dumbbellDeclineBenchPress,
        dumbbellFlatBenchPress,
        dumbbellInclineBenchPress,
        barbellDeclineBenchPress,
        barbellFlatBenchPress,
        barbellInclineBenchPress,
        machineInclineBenchPress,
        smithMachineBenchPress,
        smithMachineDeclineBenchPress,
        smithMachineInclineBenchPress,
        smithMachineCloseGripBenchPress,
        machineChestPress,
        cableChestPress,
        cableInclineChestPress,
        bandChestPress,
        dumbbellDeclineFly,
        dumbbellFly,
        dumbbellInclineFly,
        machineFly,
        benchCableFly,
        cableCrossoverFly,
        inclineBenchCableFly,
        declinePushup,
        diamondPushup,
        hinduPushup,
        inclinePushup,
        kneePushup,
        pikePushup,
        pushup,
        potationPushup,
        weightedPushup,
        lyingDumbbellPullover,
        dumbbellSquatBenchPress,
        plateInclineChestPress,
        plateDeclineChestPress,
        plateBenchPress,
        plateChestPress,
        archerPushup,
        widePushup,
        chestStretch,
        wideGripBenchPress,
        barbellReverseGripBenchPress,
        isometricBenchPress,
        dumbbellInclineSqueezePress,
        diamondPress,
        cableInclineBenchPress,
        cableBenchPress,
        dumbbellFloorHammerPress,
        dumbbellFloorChestPress,
        declineChestPress,
        inclineChestPress,
        lyingBarbellPullover,
        platePress,
        cableCrossoverLowFly,
        compensationPushup,
        cableCrossoverHighFly,
        landmineChestPress,
        bandedDumbbellPress,
        inclineFly,
        shoulderFoamRoller,
        handReleasePushup,
        cableDeclineBenchPress
    ]

}





/*
머신 인클라인 벤치 프레스 (가슴, 삼두)
머신 인클라인 벤치 프레스(가슴, 삼두)
 스미스 머신 벤치 프레스(가슴, 삼두)
 스미스 머신 디클라인 벤치 프레스(가슴,삼두)
 스미스 머신 인클라인 벤치 프레스(가슴, 삼두)
 머신 체스트 프레스(가슴, 어깨)
 케이블 체스트 프레스(가슴, 어깨)
 케이블 인클라인 체스트 프레스(가슴, 어깨)
 밴드 체스트 프레스(가슴, 어깨)
 덤벨 디클라인 플라이(가슴)
 덤벨 플라이(가슴)
 덤벨 인클라인 플라이(가슴, 어깨)
 머신 플라이(팩 덱 플라이) (가슴)
 벤치 케이블 플라이 (가슴, 어깨)
 케이블 크로스오버 플라이 (가슴, 어꺠)
 인클라인 벤치 케이블 플라이(가슴, 어꺠)
 디클라인 푸시 업(가슴, 어깨)
 다이아몬드 푸시 업(가슴, 어깨)
 힌두 후시 업(가슴, 어꺠)
 인클라인 푸시 업(가슴, 어꺠)
 니 푸시 업(가슴, 삼두)
 파이크 푸시 업(가슴,어꺠)
 푸시 업(가슴, 어깨)
 포테이션 푸시 업(가슴, 삼두)
 중량 푸시 업(가슴, 어깨)
 라잉 덤벨 풀오버(가슴, 삼두)
 덤벨 스쿼즈 벤치 프레스(가슴, 어깨)
 플레이트 인클라인 체스트 프레스(가슴, 어꺠)
 플레이트 디클라인 체스트 프레스(가슴, 어깨)
 플레이트 벤치 프레스(가슴, 어깨)
 플레이트 체스트 프레스(가슴, 어깨)
 아처 푸시 업(가슴, 어깨)
 와이드 푸시 업(가슴, 어꺠)
 무릎 대고 푸시 업(가슴, 어꺠)
 가슴 스트레칭(가슴)
 와이드 그립 벤치 프레스(가슴, 어꺠)
 스미스 머신 클로즈 그립 벤치 프레스(가슴, 어꺠)
 바벨 리버스 그립 벤치 프레스(가슴, 어꺠)
 정지 벤치 프레스(가슴, 어깨)
 덤벨 인클라인 스쿼즈 프레스(가슴, 어꺠)
 다이아몬드 프레스(가슴, 어깨)
 케이블 인클라인 벤치 프레스(가슴, 어꺠)
 케이블 벤치 프레스(가슴, 어꺠)
 덤벨 플로어 해머 프레스 (가슴, 어꺠)
 덤벨 플로어 체스트 프레스 (가슴, 어깨)
 디클라인 체스트 프레스(가슴, 어꺠)
 인클라인 체스트 프레스(가슴, 어꺠)
 라잉 바벨 풀오버(가슴, 등)
 플레이트 프레스(가슴, 삼두)
 케이블 크로스오버 로우 플라이(가슴, 어깨)
 보수 푸시 업(가슴, 어꺠)
 케이블 크로스오버 하이 플라이(가슴, 어꺠)
 랜드마인 체스트 프레스(가슴, 어깨)
 범델 데벨 프레스(가슴, 어깨)
 인클라인 플라이(가슴, 어꺠)
 어깨 폼롤러 (가슴, 어깨)
 핸드 릴리즈 푸시 업(가슴, 등)
 케이블 디클라인 벤치 프레스(가슴, 어깨)
 
 
 */
