//
//  ARView.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import SwiftUI
import RealityKit

struct ArView : View {
    var body: some View {
        
        ARViewContainer().edgesIgnoringSafeArea(.all)

    }
}
struct ARViewContainer:  UIViewRepresentable{
    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)
        
        let anchor = try! Mars.loadScene()
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ArView()
    }
}

