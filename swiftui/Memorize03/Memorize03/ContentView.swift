//
//  ContentView.swift
//  Memorize03
//
//  Created by shanquan on 2024/12/7.
//

import SwiftUI

struct ContentView: View {
    let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    @State var cardCount = 4

    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            Spacer()
            cardAdjuster
        }
        .padding()
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                cardCount += offset
            },
            label: {
                Image(systemName: symbol)
            }
        )
        .font(.largeTitle)
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View {
        return cardCountAdjuster(
            by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder: some View {
        return cardCountAdjuster(
            by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }

    var cards: some View {
        //LazyVGrid 会使网格占用尽可能少的空间，如果没有表情时，其空间会被压缩，会展示 2 个黄条
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                //在 SwiftUI 中，aspectRatio 是一个用于控制视图（尤其是图像）纵横比的修饰符。它确保视图在调整大小时保持特定的宽高比，从而避免图像被拉伸或压缩
                //aspectRatio：一个 CGFloat，表示宽度与高度的比例。
                //contentMode：指定如何调整图像以适应给定的空间，常用的选项有 .fit 和 .fill。
                    .aspectRatio(2/3,contentMode: .fit)

            }
        }
        .foregroundColor(.orange)
    }

    var cardAdjuster: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }

    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true

    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)

        ZStack {
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture(count: 1) {
            debugPrint("tapped")
            isFaceUp.toggle()
        }

    }
}

#Preview {
    ContentView()
}
