//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
// 把按钮的操作抽象到一个方法中

import SwiftUI

struct ContentView5: View {
    let emojis0: [String] = ["👻", "🧅", "👿", "🍊", "🍎", "🍍","🍐"]
    //数组的简写
    let emojis: [String] = ["👻", "🧅", "👿", "🍊", "🍎", "🍍","🍐", "🍓","🍇", "🍉", "🍌",]
    @State var cardCount: Int = 4

    var body: some View {
        //hstack 有 viewBuilder修饰, 里面不能使用 for 循环
        VStack {
            cards
            cardCountAdjust
        }
        .padding()
    }

    var cards:some View{
        HStack {
            //foreach 可以创建视图
            ForEach(0..<cardCount, id: \.self) { index in
                CardView5(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }

    var cardCountAdjust:some View{
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.headline)
    }

    var cardRemover:some View{
        Button(
            action: {
                cardCount -= 1
            },
            label: {
                Text(Image(systemName: "folder.fill.badge.minus"))
            })
    }

    var cardAdder:some View{
        Button(
            action: {
                cardCount += 1
            },
            label: {
                Text(Image(systemName: "plus.rectangle.on.folder.fill"))
            })
    }
}

struct CardView5: View {
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
    ContentView5()
}
