//
//  ContentView.swift
//  PiPicoBluetooth
//
//  Created by Abijah Kajabika on 02.05.2023.
//

import SwiftUI
import CoreBluetooth

struct BluetoothView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView{
            if(bluetoothViewModel.connectedToPeripheral != nil){
                PeripheralView(peripheral: bluetoothViewModel.connectedToPeripheral, droneAcceleration: bluetoothViewModel.droneAcceleration, disconnectAction: {
                    bluetoothViewModel.disconnectFromPeripheral(bluetoothViewModel.connectedToPeripheral!)
                })
            }else{
                List(bluetoothViewModel.peripherals, id: \.identifier) { peripheral in
                    Button{
                        bluetoothViewModel.connectToPeripheral(peripheral)
                    } label: {
                        VStack{
                            Text(peripheral.name ?? "unnamed device")
                            Text("\(peripheral.identifier)")
                                .fontWeight(.semibold)
                        }
                    }
                }
                .navigationTitle("Bluetooth Peripherals")
            }
        }
    }
}

struct BluetoothView_Previews: PreviewProvider {
    static var previews: some View {
        BluetoothView()
    }
}
