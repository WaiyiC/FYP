//
//  viewModel.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import Foundation
import UIKit
import PencilKit

class ViewModel: ObservableObject{
    @Published var drawing: UIImage?
    @Published var canvasView = PKCanvasView()
    @Published var isShowingView = false
}
