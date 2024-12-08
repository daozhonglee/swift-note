//
//  ContentView.swift
//  Memorize04
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

struct EmojiMomoryGameView: View {
    //声明一个 vm 指针指向 viewmodel
    var viewModel: EmojiMemoryGame = EmojiMemoryGame()

    @State var cardCount = 4

    var body: some View {
        VStack {
            ScrollView {
                cards
            }
        }
        .padding()
    }

    var cards: some View {
        // GridItem的垂直和水平间距设置为零，GridItem的 spacing 是垂直间距，LazyVGrid是水平间距
        LazyVGrid(
            columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
            spacing: 0
        ) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2 / 3, contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    //这里必须要手动忽略外部名称，否则在调用构造方法的时候，还需要传参数名
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
                //长宽比设置为 1，则会自动适配 card 的长宽比
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiMomoryGameView()
}
