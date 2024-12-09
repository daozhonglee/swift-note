//
//  EmojiMemoryGame.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/7.
//
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    private static func creatMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberofPairsOfCards: 2) { (index) in
            if emojis.indices.contains(index) {
                return emojis[index]
            } else {
                return "⁉️"
            }
        }
    }

    @Published private var model = creatMemoryGame()

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    func shuffle() {
        model.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
