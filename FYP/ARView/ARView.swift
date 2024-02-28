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
    @objc func handelTap(_ recognizer: UITapGestureRecognizer){
        guard let view = self.view else{return}
        let tapLocation = recognizer.location(in: view)
        
        if let entity = view.entity(at: tapLocation) as? ModelEntity{
            entity.model?.materials = []
        }
    }
}

struct ARViewContainer:  UIViewRepresentable{
    @Binding var modelConfirmForPlacement : Model?
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        context.coordinator.view = arView
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handelTap)))
        
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
                
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                
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


