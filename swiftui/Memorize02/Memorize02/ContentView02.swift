//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
//
//增加 button 用于控制 card 的增减
//使用 image 视图添加按钮的样式

import SwiftUI

struct ContentView02: View {
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
                    CardView02(content: emojis[index])
                }
            }
            .foregroundColor(.orange)
            .padding()
            HStack {
                Button(
                    action: {
                        if cardCount > 1 {
                            cardCount -= 1
                        }
                    },
                    label: {
                        Image(systemName: "rectangle.stack.badge.minus.fill")
                    })

                Spacer()
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
            .imageScale(.large)
            .font(.largeTitle)
        }
    }
}
struct CardView02: View {
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
    ContentView02()
}
