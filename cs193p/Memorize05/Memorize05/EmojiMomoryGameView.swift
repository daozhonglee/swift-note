//
//  ContentView.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

struct EmojiMomoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    @State var cardCount = 4

    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
        }
        Button("shuffle") {
            viewModel.shuffle()
        }
        .padding()
    }

    var cards: some View {
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
            spacing: 0
        ) {
            //foreach 中，默认展示对应索引的 card，shuffle 会将数组打乱，但是索引是不变的，所以 shuffle 时，只是淡如淡出的效果，我们希望的效果是整个卡片在视图中移动（飞来飞去），而不仅是卡片中的内容在变化
            //  id: \.self 表示通过索引值作为标识符，这样就可以正确地识别出哪个元素被添加或删除了
            //  .self 指的是数组索引（整数）本身
            //            ForEach(viewModel.cards, id: \.self) { card in
            //                CardView(card)
            //                    .aspectRatio(2 / 3, contentMode: .fit)
            //                    .padding(4)
            //            }
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

struct CardView: View {
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
    EmojiMomoryGameView(viewModel: EmojiMemoryGame())
}
