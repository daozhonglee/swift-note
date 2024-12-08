//
//  EmojiMemoryGame.swift
//  Memorize03
//
//  Created by shanquan on 2024/12/7.
//

import SwiftUI

class EmojiMemoryGame{
    //如果不加 private，那么 view 可以直接控制和修改 model
    //加 private 将 model 变成只有 VM 可以控制
    // 加了 private，那么 Model 和 View 就完全分离了，对应与在Model 使用 @State 的情况下，Model 和 View 是耦合的
    private var model: MemoryGame<String>
    
    //class 默认会有一个无参的构造方法，但该构造方法只有在所有变量都有默认值的情况下才起作用，所以如果存在有没有默认值的属性，必须声明一个构造方法


    //因为 model是 private 的，提供另一个计算属性用于获取 model 的 cards
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    //注意这里在使用 Card 时，使用的是 外部类.内部类 的形式获取的 Card，因为 Card 是嵌套类型
    //这里的 choose 就是 MVVM 中 VM 的意图 intent
    func choose(card: MemoryGame<String>.Card){
        //这里可以不写形参的原因是 model 中的chooseCard将参数外部名称设置为了 _
        model.chooseCard(card)

    }
}
