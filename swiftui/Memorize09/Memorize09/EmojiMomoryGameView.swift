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
                .onTapGesture {
                    withAnimation(.interactiveSpring(duration: 1)) {
                        viewModel.choose(card)
                    }
                }
        }
        .foregroundColor(viewModel.color)
    }

    private func scoreChange(causedBy card: Card) -> Int{
        return 0
    }
}

#Preview {
    EmojiMomoryGameView(viewModel: EmojiMemoryGame())
}
