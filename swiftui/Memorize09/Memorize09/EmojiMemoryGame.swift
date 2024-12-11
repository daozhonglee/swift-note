//
//  EmojiMemoryGame.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/7.
//
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    private static func creatMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberofPairsOfCards: 8) { (index) in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "⁉️"
            }
        }
    }

    @Published private var model = creatMemoryGame()

    var cards: [Card] {
        model.cards
    }

    var color: Color {
        Color.orange
    }

    var score: Int {
        model.score
    }

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: Card) {
        model.choose(card)
    }

}
