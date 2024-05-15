//
//  ARView.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import SwiftUI
import RealityKit
import ARKit
import UIKit
import FocusEntity


struct ArView : View {
    @State private var isPlacementEnable = false
    @State private var selectedModel : Model?
    @State private var modelConfirmForPlacement : Model?
    @State private var isAnimating = false
    
    private var models: [Model] = {
        let filemanager = FileManager.default
        guard let path = Bundle.main.resourcePath, let
                files = try?
                filemanager.contentsOfDirectory(atPath: path)
        else{
            return[]
        }
        
        
        var availableModels :[Model] = []
        for filename in files where
        filename.hasSuffix("usdz"){
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName:modelName)
            availableModels.append(model)
        }
        return availableModels
    }()
    
//    private var rotationTimes: [Model: TimeInterval] = {
//        // Define the rotation times for each model
//        var rotationTimes: [Model: TimeInterval] = [:]
//
//        for i in 1...12 {
//            let modelName = "model\(i)"
//            let model = Model(modelName: modelName)
//            let rotationTime = TimeInterval(i) * 5.0 // Adjust the rotation time calculation as needed
//            rotationTimes[model] = rotationTime
//        }
//
//        return rotationTimes
//    }()
    
    var body: some View {
        ZStack(alignment: .bottom){
            
            ARViewContainer(modelConfirmForPlacement: self.$modelConfirmForPlacement)
            if self.isPlacementEnable {
                PlacementButtnView(isPlacementEnable: self.$isPlacementEnable, selectedModel: self.$selectedModel, modelConfirmForPlacement: self.$modelConfirmForPlacement)
            } else{
                ModelPickerView(isPlacementEnable: self.$isPlacementEnable, selectedModel: self.$selectedModel, models: self.models)
            }
        }
    }
}

class Coordinator: NSObject{
    weak var view: ARView?
    var currentScale: Float = 1.0
    
    @objc func handleLongPress(_ recognizer: UITapGestureRecognizer? = nil) {
        // Check if there is a view to work with
        guard let view = self.view else { return }
        
        // Obtain the location of a tap or touch gesture
        let tapLocation = recognizer!.location(in: view)
        
        // Checking if there's an entity at the tapped location within the view
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            
            // Check if this entity is anchored to an anchor
            if let anchorEntity = entity.anchor {
                // Remove the model from the scene
                anchorEntity.removeFromParent()
                
                print("DEBUG: Deleted model from scene")
            }
        }
    }
    @objc func pinch(_ recognizer: UIPinchGestureRecognizer) {
            guard let view = self.view else { return }
            
            if recognizer.state == .began {
                currentScale = 1.0
            }
            
            let scale = Float(recognizer.scale)
            let scaledScale = scale * currentScale
            
            if let entity = view.entity(at: recognizer.location(in: view)) as? ModelEntity {
                entity.scale = SIMD3<Float>(repeating: scaledScale)
            }
            
            if recognizer.state == .ended {
                currentScale = scaledScale
            }
        }
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
            guard let view = self.view else { return }

            let location = recognizer.location(in: view)

            if let entity = view.entity(at: location) as? ModelEntity {
                let translation = recognizer.translation(in: view)

                var transform = entity.transform
                transform.translation += SIMD3<Float>(Float(translation.x / 500), Float(-translation.y / 500), 0)
                entity.transform = transform

                recognizer.setTranslation(.zero, in: view)
            }
        }
    }
    
    struct ARViewContainer:  UIViewRepresentable{
        @Binding var modelConfirmForPlacement : Model?
        
        func makeUIView(context: Context) -> ARView {
            let arView = ARView(frame: .zero)
            context.coordinator.view = arView
            
            
            let config = ARWorldTrackingConfiguration()
            config.planeDetection = [.horizontal, .vertical]
            config.environmentTexturing = .automatic
            
            if ARWorldTrackingConfiguration
                .supportsSceneReconstruction(.mesh){
                config.sceneReconstruction = .mesh
            }
            
            arView.session.run(config)
            _ = FocusEntity(on: arView, style: .classic())
            
            return arView
        }
        func updateUIView(_ uiView: ARView, context: Context) {
            if let model = self.modelConfirmForPlacement {
                
                if let modelEntity = model.modelEntity{
                    print("DEBUG: adding model to scene - \(model.modelName)")
                    
                    let anchorEntity = AnchorEntity(plane: .any)
                    
                    modelEntity.generateCollisionShapes(recursive: true)
                    
                    anchorEntity.addChild(modelEntity.clone(recursive: true))
                    
                   
                    
                    let longPressGesture = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
                    let rotate = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
                    let scale = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.pinch(_:)))
                    let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePanGesture(_:)))
                    uiView.addGestureRecognizer(panGesture)
                    uiView.addGestureRecognizer(scale)
                    uiView.addGestureRecognizer(longPressGesture)
                    uiView.addGestureRecognizer(rotate)
                    
                    uiView.scene.addAnchor(anchorEntity)
                }else{
                    print("DEBUG: Unable to load modelEntity for - \(model.modelName)")
                }
                
                
                DispatchQueue.main.async{
                    self.modelConfirmForPlacement = nil
                }
            }
        }
        func makeCoordinator() -> Coordinator {
            Coordinator()
        }
}


class CustomARView: ARView{
    var focusEntity: FocusEntity?
    
    init() {
        super.init(frame: .zero)
        
        self.setUpFocusEntity()
        self.setUpARView()
    }
    
    @MainActor override required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpFocusEntity() {
        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))
    }
    func setUpARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }
        
        self.session.run(config)
    }
}

extension CustomARView: FocusEntityDelegate{
    func toTrackingState(){
        print("tracking")
    }
    func toInitializingState(){
        print("initializing")
    }
}

struct ModelPickerView : View{
    @Binding var isPlacementEnable : Bool
    @Binding var selectedModel : Model?
    
    var models: [Model]
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators:false)
        {
            HStack(spacing: 30){
                ForEach(0 ..< self.models.count){ index in
                    Button(action: {
                        print("DEBUG: selected model with name:\(self.models[index].modelName)")
                        self.selectedModel = self.models[index]
                        self.isPlacementEnable = true
                    }) {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(.black.opacity(0.5))
    }
}

struct PlacementButtnView : View{
    @Binding var isPlacementEnable : Bool
    @Binding var selectedModel : Model?
    @Binding var modelConfirmForPlacement : Model?
    
    var body: some View{
        HStack{
            Button(action: {
                print("DEBUG: Cancel model placement.")
                
                self.resetPlacement()
            }) {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.5))
                    .cornerRadius(40)
                    .padding(20)
            }
            
            Button(action: {
                print("DEBUG: Confirm model placement.")
                self.modelConfirmForPlacement = self.selectedModel
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .background(.white.opacity(0.5))
                    .cornerRadius(40)
                    .padding(20)
            }
        }
    }
    func resetPlacement(){
        self.isPlacementEnable = false
        self.selectedModel = nil
    }
}
#if DEBUG
struct ArView_Previews : PreviewProvider {
    static var previews: some View {
        ArView()
    }
}
#endif

