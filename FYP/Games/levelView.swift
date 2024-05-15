//
//  levelView.swift
//  FYP
//
//  Created by Waiyi on 15/5/2024.
//

import SwiftUI

struct levelView: View {
    let level: Level
    var body: some View {
        VStack {
            Image(level.imageName)
                .resizable() .frame(maxWidth: 300, maxHeight: 600)
                .aspectRatio(contentMode: .fit)
            Text(level.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(3)
            
        }
        }
    }
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            levelView(level: leveldata[0])
        }
    }

