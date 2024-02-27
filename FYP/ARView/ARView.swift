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
            ZStack{
                ARViewContainer().edgesIgnoringSafeArea(.all)
                button.padding(50)
                
            }.sheet(isPresented: isShowingView,onDismiss: {viewModel.isShowingView = false}){
                selectView().presentationDetents([.medium])
            }
        }
        var button : some View {
            HStack{
                VStack{
                    Spacer()
                    Button(action: {viewModel.isShowingView = true}){
                        ZStack {
                            Circle()
                                .foregroundColor(.blue)
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "scribble")
                                .imageScale(.large)
                                .foregroundColor(.white)
                        }
                    }
                }
                Spacer()
            }
        }
        
    }

    struct ARViewContainer:  UIViewRepresentable{
        func makeUIView(context: Context) -> some UIView {
            let arView = ARView(frame: .zero)
            
            let anchor = try! Earth.loadScene()
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
    

