//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
// swiftui 给属性添加 state, 不加 state 则 view 不可变，无法调用 isFaceUp.toggle()

import SwiftUI

struct ContentView2: View {
    var body: some View {
        HStack{
            CardView2(content: "👻", isFaceUp: true)
            CardView2(content: "🧅")
            CardView2(content: "👿")
            CardView2(content: "🍊")
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView2: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }.onTapGesture {
            debugPrint("tapped")
            isFaceUp.toggle()
        }
        .foregroundColor(.orange)
    }
}

#Preview {
    ContentView2()
}
