//
//  PeripheralView.swift
//  PiPicoBluetooth
//
//  Created by Abijah Kajabika on 02.05.2023.
//

import SwiftUI
import CoreBluetooth



struct PeripheralView: View {
    var peripheral: CBPeripheral!
    var droneAcceleration: AccelerationData
    
    var disconnectAction: () -> Void
    
    init(peripheral: CBPeripheral!, droneAcceleration: AccelerationData, disconnectAction: @escaping () -> Void) {
        self.peripheral = peripheral
        self.droneAcceleration = droneAcceleration
        self.disconnectAction = disconnectAction
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Name: ")
                Text(peripheral.name ?? "unamed")
            }
            HStack{
                Text("ID: ")
                Text("\(peripheral.identifier)")
            }
            Spacer()
            VStack{
                Text("Data")
                    .font(.headline)
                HStack{
                    Text("Pitch: ")
                        .font(.caption)
                    Text("\(droneAcceleration.pitch)")
                        .font(.caption)
                }
                HStack{
                    Text("Roll: ")
                        .font(.caption)
                    Text("\(droneAcceleration.roll)")
                        .font(.caption)
                }
                HStack{
                    Text("Yaw: ")
                        .font(.caption)
                    Text("\(droneAcceleration.yaw)")
                        .font(.caption)
                }
            }
            Spacer()
            Button{
                disconnectAction()
            } label: {
                Text("Disconnect")
            }
        }
    }
}
