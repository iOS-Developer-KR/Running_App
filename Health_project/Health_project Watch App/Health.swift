//
//  Health.swift
//  Health_project Watch App
//
//  Created by Taewon Yoon on 3/11/24.
//

import Foundation
import HealthKit

class Health {
    let healthStore = HKHealthStore()
    let distanceType = HKQuantityType(.distanceWalkingRunning)
    
    func writeData() {
        healthStore.requestAuthorization(toShare: [distanceType], read: nil) { success, error in
            if success {
                
            } else {
                
            }
        }
    }
    
    func saveData() {
        let startDate = Calendar.current.date(bySettingHour: 14, minute: 35, second: 0, of: Date())!
        let endDate = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: Date())!
        
        let distanceQuantity = HKQuantity(unit: HKUnit.meter(), doubleValue: 628.0)
        
        let sample = HKQuantitySample(type: distanceType,
                                      quantity: distanceQuantity,
                                      start: startDate,
                                      end: endDate)
        
        healthStore.save(sample) { success, error in
            if success {
                
            } else {
                
            }
        }
    }
    
}
