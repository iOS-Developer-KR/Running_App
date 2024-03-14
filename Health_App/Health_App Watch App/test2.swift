//
//  test2.swift
//  Health_App Watch App
//
//  Created by Taewon Yoon on 3/14/24.
//

import SwiftUI
import HealthKit

struct test2: View {
    @State private var heartRate: Double = 0
    
    var body: some View {
        VStack {
            Text("Heart Rate: \(heartRate)")
                .font(.title)
            
            Button(action: {
                print("눌렸는데")
                self.getHeartRate()
            }) {
                Text("Get Heart Rate")
                    .font(.headline)
            }
        }
    }
    
    private func getHeartRate() {
        let healthStore = HKHealthStore()
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let date = Date()
        let predicate = HKQuery.predicateForSamples(withStart: date.addingTimeInterval(-60), end: date, options: .strictEndDate)
        print("debug1")
        let query = HKStatisticsQuery(quantityType: heartRateType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
            print("debug2")
            print(result?.averageQuantity().debugDescription)
            
            guard let result = result, let quantity = result.averageQuantity() else {
                print("debug3")
                return
            }
            print("debug4")
            self.heartRate = quantity.doubleValue(for: HKUnit(from: "count/min"))
            print("debug5")
        }
        healthStore.execute(query)
    }
}
