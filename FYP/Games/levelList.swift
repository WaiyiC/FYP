//
//  levelList.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import SwiftUI

import SwiftUI

struct levelList: View {
    var body: some View {
        NavigationStack{
            List{
                ForEach(1..<20) { i in
                    NavigationLink {
                        level()
                    } label: {
                        Text("Level \(i)")
                    }
                }
            }
            .toolbar(.visible)
            .navigationTitle("Level")
            .navigationBarTitleDisplayMode(.inline)
        }
       
    }
}

#Preview {
    levelList()
}
