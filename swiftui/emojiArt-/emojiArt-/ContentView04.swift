//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
// 在视图添加按钮，点击按钮后改变视图的状态

import SwiftUI

struct ContentView4: View {
    let emojis0: [String] = ["👻", "🧅", "👿", "🍊", "🍎", "🍍","🍐"]
    //数组的简写
    let emojis: [String] = ["👻", "🧅", "👿", "🍊", "🍎", "🍍","🍐", "🍓","🍇", "🍉", "🍌",]
    @State var cardCount: Int = 4

    var body: some View {
        //hstack 有 viewBuilder修饰, 里面不能使用 for 循环
        VStack {
            HStack {
                //foreach 可以创建视图
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView4(content: emojis[index])
                }
            }
            .foregroundColor(.orange)

            HStack {
                Button(
                    action: {
                        cardCount -= 1
                    },
                    label: {
                        Text(Image(systemName: "folder.fill.badge.minus"))
                    })
                Spacer()
                Button(
                    action: {
                        cardCount += 1
                    },
                    label: {
                        Text(Image(systemName: "plus.rectangle.on.folder.fill"))
                    })
            }
            .imageScale(.large)
            .font(.headline)
        }
        .padding()
    }
}

struct CardView4: View {
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
    ContentView4()
}
