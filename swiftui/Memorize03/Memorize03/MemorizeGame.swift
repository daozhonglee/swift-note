//
//  MemorizeGame.swift
//  Memorize03
//
//  Created by shanquan on 2024/12/7.
//
// 让 当前 Model 都是泛型的
struct MemoryGame<CardContent> {
    // private 让 cards 只能在这个结构体中访问，否则其他类可以直接修改 cards
    // 所有的行为都应该通过这个结构体的方法来实现
    // private(set) 会将 set 方法设置为私有, get 依然是公有的
    private(set) var cards: [Card]

    // cardContentFactory 函数式编程的例子，通过传递cardContentFactory函数，model 就不用关心 content 的具体类型了
    // 其实也可以传泛型
    init(
        numberofPairsOfCards: Int,
        cardContentFactory: (Int) -> CardContent
    ) {
        cards = [Card]()
        for pairIndex in 0..<numberofPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }

    func chooseCard(_ card: Card) {

    }

    //声明一个泛型类型的 Card，会使用 CardContent 作为内容
    struct Card {
        var isFaceUp = false
        var isMatched = false
        //内容不会随着游戏进行而变化，所以是 let
        let content: CardContent
    }
}
