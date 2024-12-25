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

    // 在 Swift 中，结构体(struct)是值类型，而不是引用类型。这意味着：
    // 默认情况下：结构体的方法不能修改其属性,这是为了保证值类型的不可变性
    // mutating 明确标记了会修改结构体状态的方法, 帮助开发者理解方法的副作用, 编译器可以进行相关检查
    // 该函数将导致写时复制
    mutating func shuffle() {
        cards.shuffle()
        debugPrint(cards)
    }

    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
