//
//  ContentView.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/8.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame

    private let aspectRatio: CGFloat = 2 / 3
    private let dealAnimation: Animation = .easeInOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50

    var body: some View {
        VStack {
            cards.foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                deck.foregroundColor(viewModel.color)
                Spacer()
                shuffle

            }
            .font(.largeTitle)
        }
        .padding()
    }

    private var score: some View {
        Text("score: \(viewModel.score)")
            .animation(nil)
    }
    private var shuffle: some View {
        Button("shuffle") {
            withAnimation {
                viewModel.shuffle()
            }
        }
    }

    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                if isDealt(card) {
                    CardView(card)
                        .matchedGeometryEffect(
                            id: card.id, in: dealingNameSpace
                        )
                        .transition(
                            .asymmetric(
                                insertion: .identity, removal: .identity)
                        )
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .overlay(
                            FlyingNumber(number: scoreChange(causedBy: card))
                        )
                        .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
                        .onTapGesture {
                            choose(card)
                        }
                    //  v1
                    //                        .transition(.opacity)
                    // v2
                    //                        .transition(
                    //                            .offset(
                    //                                x: CGFloat.random(in: -1000...1000),
                    //                                y: CGFloat.random(in: -1000...1000)
                    //                            )
                    //                        )

                }
            }
        }

    }

    @State private var dealt = Set<Card.ID>()

    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }

    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }

    @Namespace private var dealingNameSpace

    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    //                    .transition(
                    //                        .offset(
                    //                            x: CGFloat.random(in: -1000...1000),
                    //                            y: CGFloat.random(in: -1000...1000)
                    //                        ))
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    //创建一个不对称的过渡
                    .transition(
                        .asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    func deal(){
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            //withAnimation，有一个特点，那就是无论闭包里返回什么，它都会返回。
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
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

    //这个小集合，如果牌ID在这个集合中，那么就已经发牌了。
    @State private var lastScoreChange = (0, causedByCardId: "")

    //要改变分数，我们必须跟踪我们拥有的最后一张牌的 ScoreChange 是什么，这意味着我们必须同时跟踪上次单击时发生的变化以及是哪张卡引起的。
    private func scoreChange(causedBy card: Card) -> Int {
        let (scoreChange, causedByCardId) = lastScoreChange
        return card.id == causedByCardId ? scoreChange : 0
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
