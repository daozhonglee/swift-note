//
//  ContentView.swift
//  Memorize01
//
//  Created by shanquan on 2024/11/27.
//
// 基于 02 的 button，继续抽象 cardRemover 等几个计算属性，使得代码更加清晰易读
// 可以跟 02 对比当前版本的改动

import SwiftUI

struct ContentView: View {
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
        .font(.largeTitle)
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
        .font(.largeTitle)
    }

    //隐式返回,下面的 return 可以省略
    // 如果你有一个普通的函数并且它只有一行代码，那么你可以省略 return
    var cards: some View{
        return HStack {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
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
