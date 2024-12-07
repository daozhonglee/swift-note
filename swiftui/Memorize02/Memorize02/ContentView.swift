//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
//
// 基于 02 的 button，继续抽象 cardRemover 计算属性，用于 card 的增减

import SwiftUI

struct ContentView: View {
    let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    @State var cardCount = 4

    var body: some View {
        VStack {
            HStack {
                // 在 SwiftUI 中，ForEach 是一个非常有用的结构，用于动态生成视图
                // 它允许开发者通过循环创建多个视图，而无需手动为每个元素编写代码。
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(content: emojis[index])
                }
            }
            .foregroundColor(.orange)
            .padding()
            HStack {
                cardRemover
                Spacer()
                cardAdder

            }
            .imageScale(.large)
            .font(.largeTitle)
        }
    }
    var cardRemover: some View {
        Button(
            action: {
                if cardCount > 1 {
                    cardCount -= 1
                }
            },
            label: {
                Image(systemName: "rectangle.stack.badge.minus.fill")
            })
    }
    var cardAdder: some View {
        Button(
            action: {
                if cardCount < emojis.count {
                    cardCount += 1
                }
            },
            label: {
                Image(systemName: "rectangle.stack.badge.plus.fill")
            })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)

        ZStack {
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture(count: 1) {
            debugPrint("tapped")
            isFaceUp.toggle()
        }

    }
}

#Preview {
    ContentView()
}
