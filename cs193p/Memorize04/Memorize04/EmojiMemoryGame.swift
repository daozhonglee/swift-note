//
//  EmojiMemoryGame.swift
//  Memorize04
//
//  Created by shanquan on 2024/12/7.
//
//

import SwiftUI

//ObservableObject 是 SwiftUI 中的一个关键协议，用于实现数据与视图之间的响应式更新机制。当遵循此协议的对象中的 @Published 属性发生变化时，会自动通知所有观察者进行界面更新。
class EmojiMemoryGame: ObservableObject {
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

    // 通过 @Published 属性包装器，意味着该属性发生变化时，会自动通知所有观察者进行界面更新
    @Published private var model = creatMemoryGame()
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    //模型是不可变的
    func shuffle() {
        model.shuffle()
        // 遵循ObservableObject协议的类，使用 @Published 属性包装器的属性发生变化时，会自动通知所有观察者进行界面更新(不需要显式调用 send 方法)
        //  objectWillChange.send()
    }

    func choose(card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}
