//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
// 利用数组传参

import SwiftUI

struct ContentView3: View {
    let emojis0: [String] = ["👻", "🧅", "👿", "🍊"]
    //数组的简写
    let emojis: [String] = ["👻", "🧅", "👿", "🍊"]

    var body: some View {
        //hstack 有 viewBuilder修饰, 里面不能使用 for 循环
        HStack {
            //foreach 可以创建视图
            ForEach(emojis.indices, id: \.self) { index in
                CardView3(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView3: View {
    let content: String
    @State var isFaceUp = true

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
    ContentView3()
}
