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
            //                .animation(.default, value: viewModel.cards)
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
//            .animation(nil)
    }
    private var shuffle: some View{
        Button("shuffle") {
            //显示动画，使用显示动画时，就会失去隐式动画的效果，因为隐式动画隐式动画适用于卡片的任何更改，不仅仅是洗牌，而是任何内容(之所以会这样是因为隐式动画时添加到 cards 上的，而不是这个 button 上
            //可以使用duration 来调试动画
            //                withAnimation(.easeInOut(duration: 1)) {
            // 弹簧效果，大部分
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
//                .overlay()
                .onTapGesture {
                    //这里是给单个 card 增加动画，当点击 shuffle 后，可以看到 card 的动画和 shuffle 的动画会同时进行，并不冲突（可以将 duration 调大些观察）
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
