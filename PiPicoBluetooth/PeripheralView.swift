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
    var receivedText: String = ""
    
    var disconnectAction: () -> Void
    
    init(peripheral: CBPeripheral!, receivedText: String, disconnectAction: @escaping () -> Void) {
        self.peripheral = peripheral
        self.receivedText = receivedText
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
                Text(receivedText)
                    .font(.body)
                    .frame(height: 300)
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
