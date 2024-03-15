//
//  ContentView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @EnvironmentObject var connect: WatchToiOS
    @State private var value = 0
    
    var body: some View {
        VStack{
            HStack{
                Text("❤️")
                    .font(.system(size: 50))
                Spacer()
                
            }
            
            HStack{
                Text("\(value)")
                    .fontWeight(.regular)
                    .font(.system(size: 70))
                
                Text("BPM")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .padding(.bottom, 28.0)
                
                Spacer()
                
            }
            
            Button {
                
            } label: {
                
            }

            
        }
        .padding()
        .onAppear {
            start()
        }
    }
    
    
    func start() {
        autorizeHealthKit()
        startHeartRateQuery(quantityTypeIdentifier: .heartRate)
    }
    
    func autorizeHealthKit() {
        print("이상하네")
        let healthKitTypes: Set = [HKQuantityType(.heartRate)]
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { result, error in
            if !result {
                print(error!.localizedDescription)
            }
        }
    }
    
    private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            self.process(samples, type: quantityTypeIdentifier)
        }
        
        let query = HKAnchoredObjectQuery(type: HKQuantityType(quantityTypeIdentifier), predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        query.updateHandler = updateHandler
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        var lastHeartRate = 0.0
        print("아니면 여기")
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                connect.sendMessage(message: ["heartRate": lastHeartRate])
                print("보내지고 있는데")
            }
            
            self.value = Int(lastHeartRate)
        }
    }
}

#Preview {
    ContentView()
}
