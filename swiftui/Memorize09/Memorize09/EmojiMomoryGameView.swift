//
//  ContentView.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

struct EmojiMomoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack {
            cards
            HStack {
                score
                Spacer()
                shuffle

            }
            .font(.largeTitle)
        }
        .padding()
    }

    private var score: some View{
        Text("score: \(viewModel.score)")
    }
    private var shuffle: some View{
        Button("shuffle") {
            withAnimation(
                .interactiveSpring(
                    response: 0.75, dampingFraction: 0.5,
                    blendDuration: 0.5)
            ) {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(4)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 100:0)
                .onTapGesture {
                    choose(card)

                }
        }
        .foregroundColor(viewModel.color)
    }

    private func choose(_ card: Card) {
        withAnimation(.interactiveSpring(duration: 1)) {
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
            debugPrint("scoreChange: \(scoreChange)")
        }
    }

    @State private var lastScoreChange = (0, causedByCardId: "")

    //要改变分数，我们必须跟踪我们拥有的最后一张牌的 ScoreChange 是什么，这意味着我们必须同时跟踪上次单击时发生的变化以及是哪张卡引起的。
    private func scoreChange(causedBy card: Card) -> Int{
        let (scoreChange, causedByCardId) = lastScoreChange
        return card.id == causedByCardId ? scoreChange : 0
    }
}

#Preview {
    EmojiMomoryGameView(viewModel: EmojiMemoryGame())
}
