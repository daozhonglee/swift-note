//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
//  1. 搭建基本的 MVVM 框架

import SwiftUI

struct EmojiMemoryView02: View {
    var viewModel: EmojiMemoryGame = EmojiMemoryGame()
    let emojis: [String] = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    var body: some View {
        ScrollView {
            cards
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            //foreach 可以创建视图
            ForEach(emojis.indices, id: \.self) { index in
                CardView02(content: emojis[index])
                    // aspectRatio 是 SwiftUI 中用于控制视图宽高比的重要修饰符
                    .aspectRatio(2 / 3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView02: View {
    let content: String
    @State var isFaceUp = true

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            debugPrint("tapped")
            isFaceUp.toggle()
        }
        // 视图前景色
        .foregroundColor(.orange)
    }
}

#Preview {
    EmojiMemoryView02()
}
