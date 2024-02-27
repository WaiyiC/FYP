//
//  ContentView.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        TabView{
            levelList().tabItem {
                Image("book").frame(width: 5, height: 5)
                .tag(1)
            }
            ArView().tabItem {
                Image("universe").frame(width: 5, height: 5)
                .tag(1)
            }
            levelList().tabItem {
                Image("launch").frame(width: 5, height: 5)
                .tag(1)
            }
            profile().tabItem {
                Image("alien").frame(width: 5, height: 5)
                 }.tag(1)
        }
    }
}

struct Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
