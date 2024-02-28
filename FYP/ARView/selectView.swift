//
//  selectView.swift
//  FYP
//
//  Created by Waiyi on 27/2/2024.
//

import SwiftUI

struct selectView: View {
    @Binding var isShowingView : Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    selectView(isShowingView: .constant(true))
}
