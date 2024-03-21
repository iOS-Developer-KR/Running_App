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
class ExerciseRoutineContainer: Identifiable { // 운동 루틴이 저장되는 곳
    
    @Relationship(deleteRule: .cascade, inverse: \ExerciseRecordContainer.routinContainer)
    var routines: [ExerciseRecordContainer] = [ExerciseRecordContainer]() // 여러개의 루틴을 저장할 수 있다
    
    var id: UUID
    var routineName: String
    var exercise: [ExerciseModel]

    
    init(id: UUID? = nil, routineName: String, exercise: [ExerciseModel]) {
        self.id = UUID()
        self.routineName = routineName
        self.exercise = exercise
        print("ExerciseRoutinContainer 초기화")
    }
}

@Model
class ExerciseRecordContainer {
    var routinContainer: ExerciseRoutineContainer?
    
    @Relationship(deleteRule: .cascade, inverse: \Exercise.recordContainer)
    var exercise: [Exercise] = [Exercise]()
    
    @Relationship(deleteRule: .cascade, inverse: \ExerciseRecord.recordContainer)
    var record: [ExerciseRecord]?
    
    init(routinContainer: ExerciseRoutineContainer? = nil, exercise: [Exercise], record: [ExerciseRecord]?) {
        self.routinContainer = routinContainer
        self.exercise = exercise
        self.record = record
        print("ExerciseRecordContainer 초기화")
    }
}

@Model
final class ExerciseRecord { // 운동 루틴 기록이 저장되는 곳
    var recordContainer: ExerciseRecordContainer?
    
    var recordDate: Date
    var totalTime: Int
    
    init(recordContainer: ExerciseRecordContainer? = nil, recordDate: Date, totalTime: Int) {
        self.recordContainer = recordContainer
        self.recordDate = recordDate
        self.totalTime = totalTime
        print("ExerciseRecord 초기화")
    }
}

@Model
class Exercise {
    var recordContainer: ExerciseRecordContainer?
    var set: Int
    var count: [Int]
    var kg: [Int]
    var finished: [Bool]
    @Relationship(deleteRule: .cascade, inverse: \ExerciseModel.exercise)
    var exerciseType: ExerciseModel?
    
    init() {
        self.set = 5
        self.count = [0,0,0,0,0]
        self.kg = [0,0,0,0,0]
        self.finished = [false, false, false, false, false]
        self.exerciseType = exerciseType
        print("Exercise만들어졌다:\(set.description) + \(count.description) + \(kg) + \(finished)")
    }
}

@Model
class ExerciseModel: Identifiable, Hashable {
//    var routineContainer: ExerciseRoutineContainer?
    var exercise: Exercise?
    var id = UUID()
    var exerciseName: String
    var part: [ExercisePart]
    var tool: ExerciseTool
    
    init(exercise: Exercise? = nil, id: UUID = UUID(), exerciseName: String, part: [ExercisePart], tool: ExerciseTool) {
        self.exercise = exercise
        self.id = id
        self.exerciseName = exerciseName
        self.part = part
        self.tool = tool
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
    static let lowingmachine = ExerciseModel(exerciseName: "로잉 머신", part: [.hamstrings, .quadriceps], tool: .machine)
    static let dumbbellDeclineBenchPress = ExerciseModel(exerciseName: "덤벨 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellFlatBenchPress = ExerciseModel(exerciseName: "덤벨 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellInclineBenchPress = ExerciseModel(exerciseName: "바벨 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let barbellDeclineBenchPress = ExerciseModel(exerciseName: "바벨 디클라인", part: [.chest, .triceps], tool: .barbell)
    static let barbellFlatBenchPress = ExerciseModel(exerciseName: "바벨 플랫 벤치 프레스", part: [.chest, .triceps], tool: .barbell)
    static let barbellInclineBenchPress = ExerciseModel(exerciseName: "바벨 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .barbell)
    static let machineInclineBenchPress = ExerciseModel(exerciseName: "머신 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .machine)
    static let smithMachineBenchPress = ExerciseModel(exerciseName: "스미스 머신 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineDeclineBenchPress = ExerciseModel(exerciseName: "스미스 머신 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineInclineBenchPress = ExerciseModel(exerciseName: "스미스 머신 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineCloseGripBenchPress = ExerciseModel(exerciseName: "스미스 머신 클로즈 그립 벤치 프레스", part: [.chest, .shoulders], tool: .machine)
    static let machineChestPress = ExerciseModel(exerciseName: "머신 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let cableChestPress = ExerciseModel(exerciseName: "케이블 체스트 프레스", part: [.chest, .shoulders], tool: .cable)
    static let cableInclineChestPress = ExerciseModel(exerciseName: "케이블 인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .cable)
    static let bandChestPress = ExerciseModel(exerciseName: "밴드 체스트 프레스", part: [.chest, .shoulders], tool: .resistanceBand)
    static let dumbbellDeclineFly = ExerciseModel(exerciseName: "덤벨 디클라인 플라이", part: [.chest], tool: .dumbbell)
    static let dumbbellFly = ExerciseModel(exerciseName: "덤벨 플라이", part: [.chest], tool: .dumbbell)
    static let dumbbellInclineFly = ExerciseModel(exerciseName: "덤벨 인클라인 플라이", part: [.chest, .shoulders], tool: .dumbbell)
    static let machineFly = ExerciseModel(exerciseName: "머신 플라이", part: [.chest], tool: .machine)
    static let benchCableFly = ExerciseModel(exerciseName: "벤치 케이블 플라이", part: [.chest, .shoulders], tool: .cable)
    static let cableCrossoverFly = ExerciseModel(exerciseName: "케이블 크로스오버 플라이", part: [.chest, .shoulders], tool: .cable)
    static let inclineBenchCableFly = ExerciseModel(exerciseName: "인클라인 벤치 케이블 플라이", part: [.chest, .shoulders], tool: .cable)
    static let declinePushup = ExerciseModel(exerciseName: "디클라인 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let diamondPushup = ExerciseModel(exerciseName: "다이아몬드 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let hinduPushup = ExerciseModel(exerciseName: "힌두 후시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let inclinePushup = ExerciseModel(exerciseName: "인클라인 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let kneePushup = ExerciseModel(exerciseName: "니 푸시 업", part: [.chest, .triceps], tool: .bodyWeight)
    static let pikePushup = ExerciseModel(exerciseName: "파이크 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let pushup = ExerciseModel(exerciseName: "푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let potationPushup = ExerciseModel(exerciseName: "포테이션 푸시 업", part: [.chest, .triceps], tool: .bodyWeight)
    static let weightedPushup = ExerciseModel(exerciseName: "중량 푸시 업", part: [.chest, .shoulders], tool: .machine)
    static let lyingDumbbellPullover = ExerciseModel(exerciseName: "라잉 덤벨 풀오버", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellSquatBenchPress = ExerciseModel(exerciseName: "덤벨 스쿼즈 벤치 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let plateInclineChestPress = ExerciseModel(exerciseName: "플레이트 인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateDeclineChestPress = ExerciseModel(exerciseName: "플레이트 디클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateBenchPress = ExerciseModel(exerciseName: "플레이트 벤치 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateChestPress = ExerciseModel(exerciseName: "플레이트 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let archerPushup = ExerciseModel(exerciseName: "아처 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let widePushup = ExerciseModel(exerciseName: "와이드 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let chestStretch = ExerciseModel(exerciseName: "가슴 스트레칭", part: [.chest], tool: .stretching)
    static let wideGripBenchPress = ExerciseModel(exerciseName: "와이드 그립 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let barbellReverseGripBenchPress = ExerciseModel(exerciseName: "바벨 리버스 그립 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let isometricBenchPress = ExerciseModel(exerciseName: "정지 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let dumbbellInclineSqueezePress = ExerciseModel(exerciseName: "덤벨 인클라인 스쿼즈 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let diamondPress = ExerciseModel(exerciseName: "다이아몬드 프레스", part: [.chest, .shoulders], tool: .bodyWeight)
    static let cableInclineBenchPress = ExerciseModel(exerciseName: "케이블 인클라인 벤치 프레스", part: [.chest, .shoulders], tool: .cable)
    static let cableBenchPress = ExerciseModel(exerciseName: "케이블 벤치 프레스", part: [.chest, .shoulders], tool: .cable)
    static let dumbbellFloorHammerPress = ExerciseModel(exerciseName: "덤벨 플로어 해머 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let dumbbellFloorChestPress = ExerciseModel(exerciseName: "덤벨 플로어 체스트 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let declineChestPress = ExerciseModel(exerciseName: "디클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let inclineChestPress = ExerciseModel(exerciseName: "인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let lyingBarbellPullover = ExerciseModel(exerciseName: "라잉 바벨 풀오버", part: [.chest, .back], tool: .barbell)
    static let platePress = ExerciseModel(exerciseName: "플레이트 프레스", part: [.chest, .triceps], tool: .machine)
    static let cableCrossoverLowFly = ExerciseModel(exerciseName: "케이블 크로스오버 로우 플라이", part: [.chest, .shoulders], tool: .cable)
    static let compensationPushup = ExerciseModel(exerciseName: "보수 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let cableCrossoverHighFly = ExerciseModel(exerciseName: "케이블 크로스오버 하이 플라이", part: [.chest, .shoulders], tool: .cable)
    static let landmineChestPress = ExerciseModel(exerciseName: "랜드마인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let bandedDumbbellPress = ExerciseModel(exerciseName: "범델 데벨 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let inclineFly = ExerciseModel(exerciseName: "인클라인 플라이", part: [.chest, .shoulders], tool: .dumbbell)
    static let shoulderFoamRoller = ExerciseModel(exerciseName: "어깨 폼롤러", part: [.chest, .shoulders], tool: .stretching)
    static let handReleasePushup = ExerciseModel(exerciseName: "핸드 릴리즈 푸시 업", part: [.chest, .back], tool: .bodyWeight)
    static let cableDeclineBenchPress = ExerciseModel(exerciseName: "케이블 디클라인 벤치 프레스", part: [.chest, .shoulders], tool: .cable)

    static var allExercies: [ExerciseModel] {
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
