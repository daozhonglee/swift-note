//
//  SwiftUIView.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        //这里使用了尾随闭包语法，所以可以这么简写
        ZStack(alignment: .top) {
            CardView(isFaceUp: true)
        }
    }
}




#Preview {
    SwiftUIView()
}
