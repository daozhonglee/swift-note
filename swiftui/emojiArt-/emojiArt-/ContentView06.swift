//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
// 把按钮的操作抽象到一个方法中，在 05 的基础上继续抽象,

import SwiftUI

struct ContentView6: View {
    let emojis0: [String] = ["👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐"]
    //数组的简写
    let emojis: [String] = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]
    @State var cardCount:Int = 4

    var body: some View {
        //hstack 有 viewBuilder修饰, 里面不能使用 for 循环
        VStack {
            cards
            cardCountAdjusts
        }
        .padding()
    }

    var cards: some View {
        HStack {
            //foreach 可以创建视图
            ForEach(0..<cardCount, id: \.self) { index in
                CardView6(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjusts: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.headline)
    }

    // !!!
    func cardcountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                cardCount += offset
            },
            label: {
                Text(Image(systemName: symbol))
            })
        .disabled(cardCount+offset<1 || cardCount+offset>emojis.count)
    }

    var cardRemover: some View {
        cardcountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }

    var cardAdder: some View {
        cardcountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView6: View {
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
    ContentView6()
}
