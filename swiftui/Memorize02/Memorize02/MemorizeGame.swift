//
//  MemorizeGame.swift
//  Memorize
//
//  Created by shanquan on 2024/11/24.
//

import Foundation

//where 是 Swift 中的泛型类型约束语句，用于限制 CardContent 泛型类型必须遵循 Equatable 协议。
struct MemoryGame<CardContent> where CardContent: Equatable {
    //只对 set 方法设置为私有
    private(set) var cards: [Card]

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))

        }
    }

    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        //      4. 对数组 extend一个小函数 简化下面的代码
        //        get{
        //            let faceUpCardIndices = cards.indices.filter {
        //                index in cards[index].isFaceUp
        //            }
        //            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        //        }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }

    // 3. 上面使用函数式编程简化下面 get/set 逻辑
    //    var indexOfTheOneAndOnlyFaceUpCard: Int?{
    //        get{
    //            var faceUpCardIndices = [Int]()
    //            for index in cards.indices{
    //                if cards[index].isFaceUp{
    //                    faceUpCardIndices.append(index)
    //                }
    //            }
    //            if faceUpCardIndices.count == 1{
    //                return faceUpCardIndices.first
    //            }else{
    //                return nil
    //            }
    //        }
    //        set{
    //            for index in cards.indices{
    //                if index == newValue{
    //                    cards[index].isFaceUp = true
    //                }
    //            }
    //        }
    //    }

    //  2. 上面给翻盘增加算法逻辑
    mutating func choose(_ card: Card) {
        // 找到数组中的第一个元素的索引
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content
                        == cards[potentialMatchIndex].content
                    {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                }
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
    }

    //1. 上面使用更简洁的写法替代下面的写法
    //    mutating func choose(_ card: Card) {
    //        //optional 的可选绑定 (Optional Binding)
    //        // chosenIndex! 强制解包 (Forced Unwrapping)
    //        if let chosenIndex = index(of: card) {
    //            cards[chosenIndex].isFaceUp.toggle()
    //        }
    //    }
    //
    //    private func index(of card: Card) -> Int? {
    //        for index in cards.indices {
    //            if cards[index].id == card.id {
    //                return index
    //            }
    //        }
    //        return nil
    //    }

    //在 Swift 中，结构体的方法如果要修改结构体的属性，必须使用 mutating 关键字。
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }

    // 让 Card 遵循 Equatable 协议（可比较）
    // Identifiable 协议是 SwiftUI 中用于标识视图的协议，它要求类型有一个 id 属性，这个属性可以用于唯一标识一个视图。
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        // 如果实现 == 方法是对比每一个属性，则 swift 会自动生成下面的方法，无需手动实现
        //因为每个属性都是 Equatable 的，所以可以直接使用 == 进行比较
        //        static func == (lhs: Card, rhs: Card) -> Bool {
        //            return lhs.content == rhs.content && lhs.isFaceUp == rhs.isFaceUp
        //            && lhs.isMatched == rhs.isMatched
        //        }

        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: String
        var debugDescription: String {
            return
                "\(id): \(content) \(isFaceUp ? "up":"down") \(isMatched ? "matched":"unmatched")"
        }

    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
