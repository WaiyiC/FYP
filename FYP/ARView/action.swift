//
//  action.swift
//  FYP
//
//  Created by Waiyi on 6/3/2024.
//


import Foundation
import UIKit

/// Message Structure for data communication
struct action: Codable {
    enum Kind : String, Codable {
        case touch = "touch"
        case text = "text"
        case image = "image"
        case help = "help"
    }
    var kind : action.Kind
    var timestamp =  NSDate().timeIntervalSinceReferenceDate
    
    var jsonData : Data? {
        if let data = try? JSONEncoder().encode(self) {
            return data
        } else {
            return nil
        }
    }
    
}

/// Data Structure for touch
struct MyGesture : Codable {
    
    enum Mode : String, Codable {
        case none = "none"
        case add = "add"
        case edit = "edit"
        case delete = "delete"
        case deleteAll = "deleteAll"
    }
    
    enum TransformType : String, Codable {
        case scale = "scale"
        case rotation = "rotation"
        case translate = "translate"
    }
    
    enum Coord : String , Codable {
        case xy = "xy"
        case xz = "xz"
    }
    
    
    enum Kind : String, Codable {
        case tap = "tap"
        case pan = "pan"
        case scale = "scale"
        case rotation = "rotation"
    }
    
    enum State : String, Codable {
        case began = "began"
        case changed = "changed"
        case ended = "ended"
        case other = "other"
    }
    
    var kind : MyGesture.Kind
    
    //operation
    var mode : MyGesture.Mode
    var transform : MyGesture.TransformType
    var coord : MyGesture.Coord
    var objectName : String
    
    //touch related event
    var state : MyGesture.State
    var scale : Double
    var rotation : Double
    var translation : CGPoint
    var locations : [CGPoint]
}



extension UIGestureRecognizer.State {
    
    var state : MyGesture.State {
        switch self {
        case .began:
            return .began
        case .changed:
            return .changed
        case .ended:
            return .ended
        default:
            return .other
        }
    }
}
