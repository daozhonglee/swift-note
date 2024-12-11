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
        //动画将调用它的频率与它正在制作的动画通道同步。
        TimelineView(.animation) { timeline in
            //下面这个是为了解决当点击匹配的卡片时，同时反转和褪色的情况
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                    .opacity(Constants.Pie.opacity)
                    .overlay(cardContents.padding(Constants.Pie.inset))
                    .padding(Constants.inset)
                    .cardify(isFaceUp: card.isFaceUp)
                //不透明度是在 ViewHierarchy 中删除或添加视图时使用的默认过渡。
                    .transition(.opacity) //默认是这样，不写也会有这个效果，可以改成其他的试试
//                    .transition(.scale)
                //这里的不透明度是为了在没有内容的时候，仍然占据空间
//                    .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
            }else{
                //
                Color.clear
            }
        }
    }
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactory)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(
                .spin(duration: 1),
                value: card.isMatched
            )
    }

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

extension Animation {
    //利用现有动画创建一个自己的动画
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: duration).repeatForever(autoreverses: false)
    }
}
