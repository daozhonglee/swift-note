//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
//
// 基于 02 的 button，继续抽象 cardRemover, 将其整合到一个方法中
// 可以跟 03 对比当前版本的改动

import SwiftUI

struct ContentView04: View {
    let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    @State var cardCount = 4

    var body: some View {
        VStack {
            cards
            cardAdjuster
        }
        .padding()
    }
    // 函数的参数
    // by 是形参名称，用于外部调用时传参，offset 是实参名称，用于内部逻辑
    // 如果只有一个参数，说明形参实惨名称是一样的
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                cardCount += offset
            },
            label: {
                Image(systemName: symbol)
            }
        )
        .font(.largeTitle)
        //禁用选项
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View {
        return cardCountAdjuster(
            by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder: some View {
        return cardCountAdjuster(
            by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }

    var cards: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView04(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }

    var cardAdjuster: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }

    }
}

struct CardView04: View {
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
    ContentView04()
}
