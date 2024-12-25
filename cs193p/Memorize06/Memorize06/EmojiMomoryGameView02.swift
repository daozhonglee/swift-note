//
//  ContentView.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//
// 这里使用GeometryReader 来根据参数动态创建卡片个数

import SwiftUI

struct EmojiMomoryGameView02: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack {
            //            ScrollView {
            cards
                .animation(.default, value: viewModel.cards)
            //            }
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    private var cards: some View {
        return GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: gridItemSize), spacing: 0)
                ],
                spacing: 0
            ) {
                ForEach(viewModel.cards) { card in
                    CardView02(card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.orange)
    }

    //计算最合适的网格宽度
    func gridItemWidthThatFits(
        count: Int, size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio

            let rowCount = (count / columnCount).rounded(.up)
            debugPrint(
                "column: \(columnCount), count: \(count), rowCount: \(rowCount)"
            )
            if rowCount * height < size.height {
                debugPrint("bb: \(columnCount)")
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        var aa = min(size.width / count, size.height * aspectRatio).rounded(
            .down)
        debugPrint("aa: \(aa)")
        aa = 1
        return aa
    }
}

struct CardView02: View {
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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMomoryGameView02(viewModel: EmojiMemoryGame())
}
