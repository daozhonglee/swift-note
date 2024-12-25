//
//  CardView.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/9.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    var card: Card

    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactory)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                //这里是在使用隐式动画，特征是无论发生什么，你都希望这发生，完全独立于任何其他动画或其他正在发生的事情，并且会覆盖显示动画
                //value 的含义是什么时候当什么条件时执行动画
                //渐入渐出效果
//                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false),value: card.isMatched)
                //线性效果
//                    .animation(.linear(duration: 1).repeatForever(autoreverses: false),value: card.isMatched)
                    .animation(
                        .spin(duration: 1),
                        value: card.isMatched
                    )
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }

    //在结构体内部定义一些常量，这样可以避免在多个地方使用相同的值时出现错误
    // 常量必须是常数
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactory: CGFloat = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

#Preview {
    CardView(
        CardView
            .Card(isFaceUp: false, isMatched: false, content: "x", id: "test")
    )
    .padding()
    .foregroundColor(.orange)
}

extension Animation{
    //利用现有动画创建一个自己的动画
    static func spin(duration: TimeInterval)-> Animation{
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}
