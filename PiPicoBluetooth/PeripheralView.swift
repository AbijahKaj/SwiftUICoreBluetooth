//
//  PeripheralView.swift
//  PiPicoBluetooth
//
//  Created by Abijah Kajabika on 02.05.2023.
//

import SwiftUI
import CoreBluetooth
import SceneKit


struct PeripheralView: View {
    var peripheral: CBPeripheral!
    var droneAcceleration: AccelerationData
    
    var errorText: String
    
    var disconnectAction: () -> Void
    
    @StateObject var coordinator = SceneCoordinator()
    
    init(peripheral: CBPeripheral!, droneAcceleration: AccelerationData, errorText: String, disconnectAction: @escaping () -> Void) {
        self.peripheral = peripheral
        self.droneAcceleration = droneAcceleration
        self.errorText = errorText
        self.disconnectAction = disconnectAction
    }
    
    var body: some View {
        ZStack{
            SceneView(
                scene: coordinator.scene,
                pointOfView: coordinator.cameraNode,
                options: [.allowsCameraControl],
                delegate: coordinator
            )
            .ignoresSafeArea(.all)
            DeviceInfo(droneAcceleration: droneAcceleration, peripheralIdentifier: peripheral.identifier, errorText: errorText, disconnectAction: disconnectAction)
        }
    }
}

class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject {
    
    var showsStatistics: Bool = false
    var debugOptions: SCNDebugOptions = []
    
    var scene = SCNScene(named: "TestScene.scn")
    var cameraNode: SCNNode? {
        scene?.rootNode.childNode(withName: "camera", recursively: false)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        //renderer.showsStatistics = self.showsStatistics
        //renderer.debugOptions = self.debugOptions
    }
}

struct DeviceInfo: View{
    
    var droneAcceleration: AccelerationData
    var peripheralName: String?
    var peripheralIdentifier: UUID
    var errorText: String
    var disconnectAction: () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Text("Name: ")
                Text(peripheralName ?? "unamed")
            }
            .padding(.top)
            .background(Color.black.opacity(0.7))
            HStack{
                Text("ID: ")
                Text("\(peripheralIdentifier)")
            }
            .background(Color.black.opacity(0.7))
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
                if errorText != "" {
                    VStack{
                        Text("Error Text")
                            .font(.subheadline)
                        Text("\(errorText)")
                            .font(.body)
                    }
                }
            }
            .background(Color.black.opacity(0.7))
            Spacer()
            Button{
                disconnectAction()
            } label: {
                Text("Disconnect")
            }
            .background(Color.black.opacity(0.7))
        }
        .padding()
    }
}
