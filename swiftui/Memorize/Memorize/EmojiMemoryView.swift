//
//  ContentView02.swift
//  emojiArt-
//
//  Created by shanquan on 2024/11/23.
//

import SwiftUI

struct EmojiMemoryView: View {
    //表示这个 ViewModel 被观察，当 viewModel 发生变化时，视图会自动刷新
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 0) {
            //foreach 可以创建视图
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    // aspectRatio 是 SwiftUI 中用于控制视图宽高比的重要修饰符
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content).font(.system(size: 100))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMemoryView(viewModel: EmojiMemoryGame())
}
