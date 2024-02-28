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
                Image("book")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            ArView().tabItem {
                Image("universe")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            levelList().tabItem {
                Image("launch")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            profile().tabItem {
                Image("alien")
            }
        }
        .toolbarBackground(.hidden, for: .tabBar)
    }
}

struct Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
