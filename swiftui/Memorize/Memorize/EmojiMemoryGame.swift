//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by shanquan on 2024/11/24.
//

import SwiftUI

//下面是闭包的写法

//func createCardContent(pairIndex: Int) -> String {
//    return [
//        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
//    ][pairIndex]
//}

class EmojiMemoryGame :ObservableObject{
    //静态变量
    private static let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    //swift无法推断返回类型
    private  static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(
            numberOfPairsOfCards: 16,
            // index 可以替换为  $0, $1 表示第二个 参数， 一次类推
            cardContentFactory: {  pairIndex in
                if emojis.indices.contains(pairIndex){
                    return EmojiMemoryGame.emojis[pairIndex]
                }else{
                    return "⁉️"
                }
            })

    }

    //Published 可以让视图自动刷新,
    @Published private var model: MemoryGame<String> = createMemoryGame()
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    // MARK: Intents

    func shuffle() {
        model.shuffle()
    }
}
