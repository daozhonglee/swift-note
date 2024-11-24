//
//  MemorizeGame.swift
//  Memorize
//
//  Created by shanquan on 2024/11/24.
//

import Foundation

struct MemoryGame<CardContent> {
    //只对 set 方法设置为私有
    private(set) var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))

        }
    }

    func choose(_ card: Card) {
        print("card choosen: \(card)")
    }

    //在 Swift 中，结构体的方法如果要修改结构体的属性，必须使用 mutating 关键字。
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    struct Card {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
}
