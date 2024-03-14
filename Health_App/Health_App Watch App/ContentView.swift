//
//  ContentView.swift
//  Health_App Watch App
//
//  Created by Taewon Yoon on 3/14/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @ObservedObject var manager = WorkoutManager()
    @State private var heartRate: Int?
    
    var body: some View {
        VStack {
            Text("\(heartRate ?? 0)")
            Text("\(manager.heartRate)")
            
            Button(action: {
                print("운동 시작하기")
                manager.requestAuthorization()
                manager.startWorkout(workoutType: .running)
                
                
            }, label: {
                Text("Button")
            })
        }
        .padding()
    }
    
    private func getHeartRate() {
        let healthStore = HKHealthStore()
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let date = Date()
        let predicate = HKQuery.predicateForSamples(withStart: date.addingTimeInterval(-60), end: date, options: .strictEndDate)
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in            
            guard let result = result, let quantity = result.averageQuantity() else {
                return
            }
            self.heartRate = Int(quantity.doubleValue(for: HKUnit(from: "count/min")))
        }
        healthStore.execute(query)
    }
}

#Preview {
    ContentView()
}
