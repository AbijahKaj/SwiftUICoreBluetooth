//
//  ContentView.swift
//  PiPicoBluetooth
//
//  Created by Abijah Kajabika on 02.05.2023.
//

import SwiftUI
import CoreBluetooth
import SceneKit

struct BluetoothView: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    @StateObject var coordinator = SceneCoordinator()
    
    var body: some View {
        ZStack{
            SceneView(
                scene: coordinator.scene,
                pointOfView: coordinator.cameraNode,
                options: [.allowsCameraControl],
                delegate: coordinator
            )
            .ignoresSafeArea(.all)
            DeviceInfo(droneAcceleration: bluetoothViewModel.droneAcceleration, peripheralName: bluetoothViewModel.connectedToPeripheral?.name, deviceFound: !bluetoothViewModel.peripherals.isEmpty, errorText: bluetoothViewModel.errorText, disconnectAction: {
                bluetoothViewModel.toggleConnection()
            })
            .onChange(of: bluetoothViewModel.droneAcceleration, perform: { newAcceleration in
                coordinator.boxNode?.eulerAngles.x = Float(newAcceleration.euler[0])
                coordinator.boxNode?.eulerAngles.y = Float(newAcceleration.euler[1])
                coordinator.boxNode?.eulerAngles.z = Float(newAcceleration.euler[2])
                
                // Using Pitch Yaw and Roll (too floating)
//                coordinator.boxNode?.simdEulerAngles.x = Float(newAcceleration.pitch)
//                coordinator.boxNode?.simdEulerAngles.y = Float(newAcceleration.yaw)
//                coordinator.boxNode?.simdEulerAngles.z = Float(newAcceleration.roll)
            })
        }
    }
}

