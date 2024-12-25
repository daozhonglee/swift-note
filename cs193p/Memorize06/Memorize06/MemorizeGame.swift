//
//  MemorizeGame.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/7.
//

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

    init(
        numberofPairsOfCards: Int,
        cardContentFactory: (Int) -> CardContent
    ) {
        cards = [Card]()
        for pairIndex in 0..<max(2, numberofPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }

    mutating func choose(_ card: Card) {
        if let choseIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[choseIndex].isFaceUp && !cards[choseIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choseIndex].content
                        == cards[potentialMatchIndex].content
                    {
                        cards[choseIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {  //当前不存在已经朝上的卡片
                    indexOfTheOneAndOnlyFaceUpCard = choseIndex
                }
                cards[choseIndex].isFaceUp = true
            }

        }
    }

    mutating func shuffle() {
        cards.shuffle()
        debugPrint(cards)
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {

        var isFaceUp = false
        var isMatched = false
        let content: CardContent

        var id: String
        var debugDescription: String {
            "id: \(id), isFaceUp: \(isFaceUp), isMatched: \(isMatched), content: \(content) \n "
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
