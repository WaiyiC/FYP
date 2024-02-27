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
                Image(systemName: "gamecontroller")
                Text("Level").tag(1)
            }
            ArView().tabItem {
                Image(systemName: "gamecontroller")
                Text("Level").tag(1)
            }
            levelList().tabItem {
                Image(systemName: "gamecontroller")
                Text("Level").tag(1)
            }
            levelList().tabItem {
                Image(systemName: "gamecontroller")
                Text("Level") }.tag(1)
        }
    }
}

#Preview {
    ContentView()
}
