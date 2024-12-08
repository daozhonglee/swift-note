//
//  ContentView.swift
//  Memorize03
//
//  Created by shanquan on 2024/12/7.
//

import SwiftUI

struct ContentView: View {
    //声明一个 vm 指针指向 viewmodel
    var viewModel: EmojiMemoryGame

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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
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
