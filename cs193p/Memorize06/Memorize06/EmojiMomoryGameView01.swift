//
//  ContentView.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//
//这里讲如何使用background 调试 view 的尺寸

import SwiftUI

struct EmojiMomoryGameView01: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    @State var cardCount = 4

    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
                    .background(.red) //cards 的尺寸
            }
            Button("shuffle") {
                viewModel.shuffle()
            }
            //可以使用背景色进行调试，查看 view 的尺寸，backgroud 会填充整个父视图（当前是button），所以可以看到 view 的尺寸
            .background(.blue)
        }
        .background(.yellow)

        .padding()
    }

    var cards: some View {
        LazyVGrid(
            //  .flexible() 是 GridItem 的默认参数
            // 也可以指定大小
            // columns: [GridItem(.fixed(40)),GridItem()],
            columns: [GridItem(.adaptive(minimum: 35), spacing: 0)],
//            columns: [GridItem(spacing: 0)],
            spacing: 0
        ) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView01: View {
    var card: MemoryGame<String>.Card

    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }

    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)

        ZStack {
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp ||  !card.isMatched ? 1:0)
    }
}

#Preview {
    EmojiMomoryGameView01(viewModel: EmojiMemoryGame())
}
