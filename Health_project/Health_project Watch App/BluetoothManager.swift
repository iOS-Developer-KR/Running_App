//
//  BluetoothManager.swift
//  Health_project Watch App
//
//  Created by Taewon Yoon on 3/11/24.
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, CBPeripheralDelegate {
    var peripheral: CBPeripheral?
    var peripheralManager: CBPeripheralManager?
    var peripheralDelegate: CBPeripheralDelegate?
    var writeCharacteristic: CBCharacteristic? // 데이터를 주변기기에 보내기 위한 characcteristic을 저장하는 변수
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager.init()
    }
    
    func sendData(heart: String) {
        do {
            let data = try JSONEncoder().encode(heart)
            peripheral?.writeValue(data, for: writeCharacteristic!, type: .withoutResponse)
        } catch {
            
        }
    }
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        
    }
}
