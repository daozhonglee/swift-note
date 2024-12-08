//
//  MemorizeGame.swift
//  Memorize04
//
//  Created by shanquan on 2024/12/7.
//
struct MemoryGame<CardContent> {
    private(set) var cards: [Card]

    init(
        numberofPairsOfCards: Int,
        cardContentFactory: (Int) -> CardContent
    ) {
        cards = [Card]()
        //max 确保最少有1对卡片
        for pairIndex in 0..<max(16, numberofPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    func chooseCard(_ card: Card) {

    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
