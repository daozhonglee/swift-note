//
//  EmojiMemoryGame.swift
//  Memorize04
//
//  Created by shanquan on 2024/12/7.
//
//

import SwiftUI

class EmojiMemoryGame {
    // 使用 static， 将 emojis 变成了静态变量，静态变量将在类变量初始化之前初始化
    private static let emojis = [
        "👻", "🧅", "👿", "🍊", "🍎", "🍍", "🍐", "🍓", "🍇", "🍉", "🍌",
    ]

    //使用静态方法的形式，优化之前创建 model 的形式,返回类型没有被优化，始终必须是显式
    private static func creatMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberofPairsOfCards: 4) { (index) in
            if emojis.indices.contains(index){
                return emojis[index]
            }else{
                return "⁉️"
            }
        }
    }

    private var model = creatMemoryGame()
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    //模型是不可变的
    func shuffle() {
        model.shuffle()
    }

    func choose(card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}
