//
//  MemorizeGame.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/7.
//

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0

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
                    debugPrint(cards[choseIndex])
                    debugPrint(cards[potentialMatchIndex])
                    if cards[choseIndex].content
                        == cards[potentialMatchIndex].content
                    {
                        cards[choseIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[choseIndex].hasBeenSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen {
                            score -= 1
                        }
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
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false
        let content: CardContent

        var id: String
        var debugDescription: String {
            "id: \(id), isFaceUp: \(isFaceUp), isMatched: \(isMatched), content: \(content) \n , hasBeenSeen: \(hasBeenSeen)"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
