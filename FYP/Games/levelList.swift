//
//  levelList.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import SwiftUI

import SwiftUI

struct levelList: View {
        let levels = leveldata
        var body: some View {
            NavigationView {
                List(levels) {
                    level in
                    NavigationLink( destination: levelView(level: level)) {
                        Text(level.title).navigationBarTitle("Artworks")
                    }
                }
            }
        }
    }
#Preview {
    levelList()
}
