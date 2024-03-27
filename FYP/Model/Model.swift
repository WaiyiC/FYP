//
//  Model.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import Foundation
import UIKit
import RealityKit
import Combine

class Model: Identifiable {
    var id = UUID()
    var modelName: String
    var realityProject: String
    var image: UIImage
    var modelEntity: ModelEntity?
    private var cancellable: AnyCancellable? = nil

    init(modelName: String, realityProject: String) {
        self.modelName = modelName
        self.realityProject = realityProject
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".rcproject"
        if let realityURL = Bundle.main.url(forResource: filename, withExtension: nil) {
            self.cancellable = ModelEntity.loadModelAsync(contentsOf: realityURL)
                .sink(receiveCompletion: { loadCompletion in
                    // Handle any potential errors or completion events
                }, receiveValue: { modelEntity in
                    self.modelEntity = modelEntity
                    print("DEBUG: Successfully loaded modelEntity for modelName: \(self.modelName)")
                })
        } else {
            print("DEBUG: Failed to find the .rcproject file for modelName: \(self.modelName)")
        }
    }
}
