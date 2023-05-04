//
//  PeripheralView.swift
//  PiPicoBluetooth
//
//  Created by Abijah Kajabika on 02.05.2023.
//

import SwiftUI
import SceneKit


class SceneCoordinator: NSObject, SCNSceneRendererDelegate, ObservableObject {
    
    var showsStatistics: Bool = false
    var debugOptions: SCNDebugOptions = []
    
    var scene = SCNScene(named: "TestScene.scn")
    var cameraNode: SCNNode? {
        scene?.rootNode.childNode(withName: "camera", recursively: false)
    }
    
    var boxNode: SCNNode? {
        scene?.rootNode.childNode(withName: "box", recursively: false)
    }
    
}

struct DeviceInfo: View{
    
    var droneAcceleration: AccelerationData
    var peripheralName: String?
    var deviceFound: Bool
    var errorText: String
    var disconnectAction: () -> Void
    
    var noPeripheralText: String {deviceFound ? "Waiting to connect" : "Searching for device"}
    
    var body: some View {
        VStack{
            Spacer()
            VStack{
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
                
                HStack{
                    Text(peripheralName ?? noPeripheralText)
                        .lineLimit(1)
                    Spacer()
                    Button{
                        disconnectAction()
                    } label: {
                        Text((peripheralName != nil) ? "Disconnect" : "Connect")
                    }
                    .foregroundColor(.primary)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.gray)
                    }
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 40)
            .background(.black.opacity(0.5))
            .cornerRadius(20)
            
        }
    }
    
}


struct DeviceInfo_Previews: PreviewProvider{
    static var previews: some View{
        DeviceInfo(droneAcceleration: AccelerationData(yaw: 0.0, pitch: 0.0, roll: 0, euler: []), deviceFound: false, errorText: "", disconnectAction: {})
    }
}
