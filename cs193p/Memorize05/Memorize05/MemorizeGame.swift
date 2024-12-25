//
//  MemorizeGame.swift
//  Memorize05
//
//  Created by shanquan on 2024/12/7.
//

//表示CardContent 是一个遵循 Equatable 协议的类型
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]

    init(
        numberofPairsOfCards: Int,
        cardContentFactory: (Int) -> CardContent
    ) {
        cards = [Card]()
        for pairIndex in 0..<max(16, numberofPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp }.only
            //极致优化：下面逻辑可以被上面1行代替
            //            let faceUpCardIndices = cards.indices.filter { cards[$0].isFac eUp }
            //            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            //下面逻辑可以被上面2行代替
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
        }
        set {
            cards.indices.forEach {
                cards[$0].isFaceUp = (newValue == $0)
            }
//                        for index in cards.indices {
//                            cards[index].isFaceUp = index == newValue
//                        }
        }
    }

    //这里使用 mutating 的原因 MemoryGame 是一个结构体（值类型），值类型的方法默认不能修改其属性
    mutating func choose(_ card: Card) {
        // optional binding
        // if let choseIndex = index(of: card){
        if let choseIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[choseIndex].isFaceUp && !cards[choseIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[choseIndex].content
                        == cards[potentialMatchIndex].content
                    {
                        cards[choseIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                    //这里的赋值可以被省略，因为在 set 中已经赋值了
                    // indexOfTheOneAndOnlyFaceUpCard = nil
                } else {  //当前不存在已经朝上的卡片
                    // 这里的赋值可以被省略, 因为在 set 中已经赋值了
                    //                    for index in cards.indices {
                    //                        cards[index].isFaceUp = false
                    //                    }
                    indexOfTheOneAndOnlyFaceUpCard = choseIndex
                }
                cards[choseIndex].isFaceUp = true
            }

        }
    }

    // 这个 index 被数组的 firstIndex 替代了，在这里只是为了讲 Optional binding
    //    func index(of card: Card) -> Int? {
    //        for index in cards.indices {
    //            if cards[index].id == card.id {
    //                return index
    //            }
    //        }
    //        return nil
    //    }

    mutating func shuffle() {
        cards.shuffle()
        debugPrint(cards)
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {

        // 如果==方法的实现是对比所有的属性，那么可以省略==方法的实现，直接用系统默认的实现
        //  static func == (lhs: Card, rhs: Card) -> Bool {
        //      return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
        //  }
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
    //Element 表示可选项，且是泛型
    var only: Element? {
        //不过这个 count 是怎么来的呢？应该是 Array 的属性
        // first 应该也是个计算属性，返回收个元素
        count == 1 ? first : nil
    }
}
