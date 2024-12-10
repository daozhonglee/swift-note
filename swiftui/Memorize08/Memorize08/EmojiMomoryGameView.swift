//
//  ContentView.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

struct EmojiMomoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3

    var body: some View {
        VStack {
            cards.animation(.default, value: viewModel.cards)
            Button("shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }

    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.color)
    }

}



#Preview {
    EmojiMomoryGameView(viewModel: EmojiMemoryGame())
}
