//
//  CardView.swift
//  Memorize07
//
//  Created by shanquan on 2024/12/9.
//
// 这里讲了如何利用 Path 来绘制一个形状，配合 Pie 一起看

import SwiftUI

struct CardView02: View {
    typealias Card = MemoryGame<String>.Card
    var card: Card

    init(_ card: Card) {
        self.card = card
    }

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)

                Path{ p in
                    p.move(to: .zero)
                    p.addLine(to: CGPoint(x: 50, y: 80))
                }
                .stroke(lineWidth: 2)
                Pie(endAngle: .degrees( 240))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.scaleFactory)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(Constants.Pie.inset)
                    )
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
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
        struct Pie{
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}

#Preview {
    CardView02(
        CardView02.Card(isFaceUp: false, isMatched: false, content: "x", id: "test")
    )
    .padding()
    .foregroundColor(.orange)
}
